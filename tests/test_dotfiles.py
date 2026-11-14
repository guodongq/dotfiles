import os
from pathlib import Path
import shutil
import subprocess
import sys
import tempfile
import unittest


ROOT = Path(__file__).resolve().parents[1]


class DotfilesTests(unittest.TestCase):
    def setUp(self):
        temp = tempfile.TemporaryDirectory()
        self.addCleanup(temp.cleanup)
        self.home = Path(temp.name) / "home"
        self.home.mkdir()
        self.env = {
            **os.environ,
            "HOME": str(self.home),
            "ZDOTDIR": str(self.home),
            "XDG_CONFIG_HOME": str(self.home / ".config"),
            "GIT_CONFIG_GLOBAL": os.devnull,
            "GIT_CONFIG_NOSYSTEM": "1",
        }

    def link(self, source, target):
        target = self.home / target
        target.parent.mkdir(parents=True, exist_ok=True)
        target.symlink_to(ROOT / source)

    def install_links(self):
        return subprocess.run(
            [
                sys.executable,
                str(ROOT / "dotbot/bin/dotbot"),
                "-d",
                str(ROOT),
                "-c",
                str(ROOT / "install.conf.yaml"),
                "--only",
                "link",
            ],
            env=self.env,
            capture_output=True,
            text=True,
            timeout=30,
        )

    @unittest.skipUnless(shutil.which("zsh"), "requires zsh")
    def test_shell_environment_is_initialized_once_and_local_overrides_win(self):
        self.link(".zprofile", ".zprofile")
        self.link(".zshrc", ".zshrc")
        brew_paths = (
            "/opt/homebrew/bin/brew",
            "/usr/local/bin/brew",
            "/home/linuxbrew/.linuxbrew/bin/brew",
        )
        # Intercept absolute Homebrew commands without changing the host installation.
        (self.home / ".zshenv").write_text(
            "for brew in " + " ".join(brew_paths) + "; do\n"
            "  functions[$brew]='\n"
            '    print -r -- call >> "$HOME/homebrew-calls"\n'
            '    print -r -- "export HOMEBREW_PREFIX=${0:h:h}"\n'
            "  '\n"
            "done\n"
            "unset brew\n"
        )
        expected_brew_calls = int(any(os.access(path, os.X_OK) for path in brew_paths))
        calls = self.home / "homebrew-calls"
        (self.home / ".zshrc.local").write_text(
            'export EDITOR=local-editor\npath=("$HOME/custom-bin" $path)\n'
        )
        integration = self.home / ".orbstack/shell/init.zsh"
        integration.parent.mkdir(parents=True)
        command = (
            'print -r -- "${DOTFILES_TEST_ORBSTACK_COUNT:-0}" "${EDITOR:-unset}"; '
            'print -l -- "${path[@]}"'
        )
        for with_orbstack in (False, True):
            if with_orbstack:
                integration.write_text("(( DOTFILES_TEST_ORBSTACK_COUNT += 1 ))\n")
            for mode in ("-lc", "-lic", "-ic"):
                with self.subTest(orbstack=with_orbstack, mode=mode):
                    if calls.exists():
                        calls.unlink()
                    result = subprocess.run(
                        ["zsh", "-d", mode, command],
                        env={**self.env, "EDITOR": "inherited-editor"},
                        capture_output=True,
                        text=True,
                        timeout=30,
                    )
                    self.assertEqual(result.returncode, 0, result.stderr)
                    header, *paths = result.stdout.splitlines()
                    editor = "local-editor" if "i" in mode else "inherited-editor"
                    self.assertEqual(header, f"{int(with_orbstack)} {editor}")
                    actual_calls = (
                        len(calls.read_text().splitlines()) if calls.exists() else 0
                    )
                    self.assertEqual(actual_calls, expected_brew_calls)
                    self.assertEqual(len(paths), len(set(paths)))
                    for directory in (".npm-global/bin", ".local/bin"):
                        self.assertIn(str(self.home / directory), paths)
                    if "i" in mode:
                        self.assertEqual(paths[0], str(self.home / "custom-bin"))

    def test_new_links_are_installed_idempotently(self):
        for _ in range(2):
            result = self.install_links()
            self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
            for source, target in (
                (".zprofile", ".zprofile"),
                (".gitignore_global", ".config/git/ignore"),
                ("gh/config.yml", ".config/gh/config.yml"),
            ):
                path = self.home / target
                self.assertTrue(path.is_symlink())
                self.assertEqual(path.resolve(), ROOT / source)

    def test_install_preserves_existing_regular_files(self):
        paths = tuple(
            self.home / target
            for target in (
                ".zprofile",
                ".config/git/ignore",
                ".config/gh/config.yml",
                "Library/Application Support/Code/User/snippets/go.json",
            )
        )
        for path in paths:
            path.parent.mkdir(parents=True, exist_ok=True)
            path.write_text("existing local settings\n")
        result = self.install_links()
        self.assertNotEqual(result.returncode, 0)
        for path in paths:
            self.assertFalse(path.is_symlink())
            self.assertEqual(path.read_text(), "existing local settings\n")

    def test_desktop_links_are_macos_only(self):
        commands = self.home / "bin"
        commands.mkdir()
        uname = commands / "uname"
        uname.write_text('#!/bin/sh\nprintf \'%s\\n\' "$DOTFILES_TEST_PLATFORM"\n')
        uname.chmod(0o755)
        self.env["PATH"] = str(commands) + os.pathsep + os.environ["PATH"]
        for platform in ("Linux", "Darwin"):
            self.env["DOTFILES_TEST_PLATFORM"] = platform
            with self.subTest(platform=platform):
                result = self.install_links()
                self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
                for source, target in (
                    (
                        "iterm2/profile.json",
                        "Library/Application Support/iTerm2/DynamicProfiles/dotfiles.json",
                    ),
                    (
                        "vscode/snippets/go.json",
                        "Library/Application Support/Code/User/snippets/go.json",
                    ),
                ):
                    path = self.home / target
                    if platform == "Darwin":
                        self.assertTrue(path.is_symlink())
                        self.assertEqual(path.resolve(), ROOT / source)
                    else:
                        self.assertFalse(path.exists())

    def test_git_ignores_local_noise_but_not_shared_project_settings(self):
        self.link(".gitignore_global", ".config/git/ignore")
        worktree = self.home / "project"
        worktree.mkdir()
        subprocess.run(
            ["git", "init", "--quiet", str(worktree)],
            env=self.env,
            check=True,
            capture_output=True,
        )
        ignored = {
            ".DS_Store",
            "nested/.DS_Store",
            "main.py.swp",
            ".claude/settings.local.json",
            "nested/.claude/settings.local.json",
        }
        shared = {
            ".claude/settings.json",
            ".vscode/settings.json",
            "main.py",
        }
        result = subprocess.run(
            ["git", "-C", str(worktree), "check-ignore", "--no-index", "--stdin"],
            input="\n".join(sorted(ignored | shared)) + "\n",
            env=self.env,
            capture_output=True,
            text=True,
            timeout=30,
        )
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual(set(result.stdout.splitlines()), ignored)

    def test_macos_preferences_are_platform_guarded(self):
        commands = self.home / "bin"
        commands.mkdir()
        stubs = {
            "uname": 'printf \'%s\\n\' "$DOTFILES_TEST_PLATFORM"\n',
            "defaults": 'printf \'%s\\n\' "$*" >> "$DOTFILES_TEST_DEFAULTS_LOG"\n',
        }
        for name, body in stubs.items():
            path = commands / name
            path.write_text("#!/bin/sh\n" + body)
            path.chmod(0o755)
        log = self.home / "defaults-calls"
        for platform in ("Linux", "Darwin"):
            with self.subTest(platform=platform):
                result = subprocess.run(
                    [str(ROOT / "macos/defaults.sh")],
                    env={
                        **self.env,
                        "PATH": str(commands) + os.pathsep + os.environ["PATH"],
                        "DOTFILES_TEST_PLATFORM": platform,
                        "DOTFILES_TEST_DEFAULTS_LOG": str(log),
                    },
                    capture_output=True,
                    text=True,
                    timeout=30,
                )
                if platform == "Darwin":
                    self.assertEqual(result.returncode, 0, result.stderr)
                    self.assertTrue(log.is_file())
                    self.assertTrue(
                        all(
                            line.startswith("write ")
                            for line in log.read_text().splitlines()
                        )
                    )
                else:
                    self.assertNotEqual(result.returncode, 0)
                    self.assertFalse(log.exists())
