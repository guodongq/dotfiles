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

    def stub_command(self, name, body):
        commands = self.home / "bin"
        commands.mkdir(exist_ok=True)
        path = commands / name
        path.write_text("#!/bin/sh\n" + body)
        path.chmod(0o755)
        self.env["PATH"] = str(commands) + os.pathsep + os.environ["PATH"]

    def run_command(self, command, *, input=None, check=True):
        result = subprocess.run(
            command,
            env=self.env,
            input=input,
            capture_output=True,
            text=True,
            timeout=30,
        )
        if check:
            self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
        return result

    def run_dotbot(self, only="link", *, check=True):
        return self.run_command(
            [
                sys.executable,
                str(ROOT / "dotbot/bin/dotbot"),
                "-d",
                str(ROOT),
                "-c",
                str(ROOT / "install.conf.yaml"),
                "--only",
                only,
            ],
            check=check,
        )

    @unittest.skipUnless(shutil.which("zsh"), "requires zsh")
    def test_shell_environment_is_initialized_once_and_local_overrides_win(self):
        self.link(".zprofile", ".zprofile")
        self.link(".zshrc", ".zshrc")
        self.env["EDITOR"] = "inherited-editor"
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
        command = (
            'print -r -- "${EDITOR:-unset}"; print -l -- "${path[@]}"'
        )
        for mode in ("-lc", "-lic", "-ic"):
            with self.subTest(mode=mode):
                if calls.exists():
                    calls.unlink()
                result = self.run_command(["zsh", "-d", mode, command])
                header, *paths = result.stdout.splitlines()
                editor = "local-editor" if "i" in mode else "inherited-editor"
                self.assertEqual(header, editor)
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
            self.run_dotbot()
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
        result = self.run_dotbot(check=False)
        self.assertNotEqual(result.returncode, 0)
        for path in paths:
            self.assertFalse(path.is_symlink())
            self.assertEqual(path.read_text(), "existing local settings\n")

    def test_desktop_links_are_macos_only(self):
        self.stub_command("uname", 'printf \'%s\\n\' "$DOTFILES_TEST_PLATFORM"\n')
        for platform in ("Linux", "Darwin"):
            self.env["DOTFILES_TEST_PLATFORM"] = platform
            with self.subTest(platform=platform):
                self.run_dotbot()
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
        self.run_command(["git", "init", "--quiet", str(worktree)])
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
        result = self.run_command(
            ["git", "-C", str(worktree), "check-ignore", "--no-index", "--stdin"],
            input="\n".join(sorted(ignored | shared)) + "\n",
        )
        self.assertEqual(set(result.stdout.splitlines()), ignored)

    def test_shell_install_is_idempotent_and_preserves_local_files(self):
        self.stub_command(
            "git",
            'printf \'%s\\n\' "$*" >> "$HOME/git-calls"\n'
            '[ "$1" = clone ] || exit 1\n'
            'mkdir -p "$4"\n',
        )
        custom = self.home / "custom"
        self.env["ZSH_CUSTOM"] = str(custom)
        self.run_dotbot("shell")
        self.assertTrue((self.home / ".oh-my-zsh").is_dir())
        for plugin in (
            "zsh-completions",
            "zsh-autosuggestions",
            "zsh-syntax-highlighting",
        ):
            self.assertTrue((custom / "plugins" / plugin).is_dir())
        for name in (".zshrc.local", ".gitconfig.local"):
            self.assertEqual(
                (self.home / name).read_text(), (ROOT / f"{name}.example").read_text()
            )
        log = self.home / "git-calls"
        clones = log.read_text()
        self.assertEqual(len(clones.splitlines()), 4)

        shell_local = self.home / ".zshrc.local"
        shell_local.write_text("existing local settings\n")
        git_local = self.home / ".gitconfig.local"
        git_local.unlink()
        git_local.symlink_to("missing-local-settings")
        for _ in range(2):
            self.run_dotbot("shell")
            self.assertEqual(log.read_text(), clones)
            self.assertEqual(shell_local.read_text(), "existing local settings\n")
            self.assertTrue(git_local.is_symlink())
            self.assertEqual(git_local.readlink(), Path("missing-local-settings"))
            self.assertFalse(git_local.exists())

    @unittest.skipUnless(shutil.which("nvim"), "requires Neovim")
    def test_nvim_explorer_navigation_shortcuts(self):
        data_home = Path(
            os.environ.get("XDG_DATA_HOME", Path.home() / ".local/share")
        )
        app_name = os.environ.get("NVIM_APPNAME", "nvim")
        snacks = data_home / app_name / "lazy" / "snacks.nvim"
        if not (snacks / "lua/snacks/init.lua").is_file():
            self.skipTest("requires installed Snacks")
        for key, directory in (
            ("XDG_DATA_HOME", "data"),
            ("XDG_CACHE_HOME", "cache"),
            ("XDG_STATE_HOME", "state"),
        ):
            self.env[key] = str(self.home / directory)
        self.run_command(
            [
                "nvim",
                "--headless",
                "-u",
                "NONE",
                "-i",
                "NONE",
                "-l",
                str(ROOT / "tests/nvim_explorer.lua"),
                str(ROOT),
                str(snacks),
            ]
        )
