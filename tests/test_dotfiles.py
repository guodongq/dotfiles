import json
import os
import shutil
import subprocess
import sys
import tempfile
import unittest
from pathlib import Path

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
            "XDG_DATA_HOME": str(self.home / "data"),
            "XDG_CACHE_HOME": str(self.home / "cache"),
            "XDG_STATE_HOME": str(self.home / "state"),
            "ZSH_CUSTOM": str(self.home / ".oh-my-zsh/custom"),
            "GIT_CONFIG_GLOBAL": os.devnull,
            "GIT_CONFIG_NOSYSTEM": "1",
        }

    def link(self, source, target):
        target = self.home / target
        target.parent.mkdir(parents=True, exist_ok=True)
        target.symlink_to(ROOT / source)

    def stub_command(self, name, body, *, interpreter="/bin/sh"):
        commands = self.home / "bin"
        commands.mkdir(exist_ok=True)
        path = commands / name
        path.write_text(f"#!{interpreter}\n" + body)
        path.chmod(0o755)
        self.env["PATH"] = str(commands) + os.pathsep + os.environ["PATH"]

    def run_command(self, command, *, input=None, check=True, cwd=None, text=True):
        result = subprocess.run(
            command,
            env=self.env,
            cwd=cwd,
            input=input,
            capture_output=True,
            text=text,
            timeout=30,
            check=False,
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

    def run_nvim(self, script, *plugins, args=()):
        nvim = shutil.which("nvim")
        if not nvim:
            self.skipTest("requires Neovim")
        data_home = Path(os.environ.get("XDG_DATA_HOME", Path.home() / ".local/share"))
        app_name = os.environ.get("NVIM_APPNAME", "nvim")
        paths = [data_home / app_name / "lazy" / plugin for plugin in plugins]
        for path in paths:
            if not path.is_dir():
                self.skipTest(f"requires installed {path.name}")
        for key, directory in (
            ("XDG_DATA_HOME", "data"),
            ("XDG_CACHE_HOME", "cache"),
            ("XDG_STATE_HOME", "state"),
        ):
            self.env[key] = str(self.home / directory)
        return self.run_command(
            [
                nvim,
                "--headless",
                "-u",
                "NONE",
                "-i",
                "NONE",
                "-l",
                str(ROOT / "tests" / script),
                str(ROOT),
                *(str(path) for path in paths),
                *args,
            ]
        )

    @unittest.skipUnless(shutil.which("zsh"), "requires zsh")
    def test_shell_environment_is_initialized_once_and_local_overrides_win(self):
        self.link(".zprofile", ".zprofile")
        self.link(".zshrc", ".zshrc")
        self.env["EDITOR"] = "inherited-editor"
        self.stub_command(
            "brew",
            "printf 'call\\n' >> \"$HOME/homebrew-calls\"\n"
            'printf \'export HOMEBREW_PREFIX="%s/brew"; '
            'export PATH="%s/brew/bin:$PATH"\\n\' "$HOME" "$HOME"\n',
        )
        calls = self.home / "homebrew-calls"
        (self.home / ".zshrc.local").write_text(
            'export EDITOR=local-editor\npath=("$HOME/custom-bin" $path)\n'
        )
        command = 'print -r -- "${EDITOR:-unset}"; print -l -- "${path[@]}"'
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
                self.assertEqual(actual_calls, 1)
                self.assertEqual(len(paths), len(set(paths)))
                for directory in (".npm-global/bin", ".local/bin"):
                    self.assertLess(
                        paths.index(str(self.home / directory)),
                        paths.index(str(self.home / "brew/bin")),
                    )
                if "i" in mode:
                    self.assertEqual(paths[0], str(self.home / "custom-bin"))

    @unittest.skipUnless(shutil.which("zsh"), "requires zsh")
    def test_shell_preserves_editor_when_neovim_is_missing(self):
        self.link(".zprofile", ".zprofile")
        self.link(".zshrc", ".zshrc")
        self.stub_command("brew", "exit 0\n")
        self.env["PATH"] = str(self.home / "bin")
        self.env["EDITOR"] = "vi"
        self.env["VISUAL"] = "vi"
        result = self.run_command(
            [
                shutil.which("zsh"),
                "-d",
                "-ic",
                'print -r -- "$EDITOR $VISUAL"; print -r -- "${aliases[vi]-native}"',
            ]
        )
        self.assertEqual(result.stdout.splitlines(), ["vi vi", "native"])

    @unittest.skipUnless(shutil.which("zsh"), "requires zsh")
    def test_python_aliases_do_not_shadow_managed_commands(self):
        self.link(".zprofile", ".zprofile")
        self.link(".zshrc", ".zshrc")
        self.stub_command("brew", "exit 0\n")
        self.stub_command("python3", "printf 'python3: %s\\n' \"$*\"\n")
        for managed in (False, True):
            with self.subTest(managed=managed):
                if managed:
                    self.stub_command("python", "printf 'managed python\\n'\n")
                    self.stub_command("pip", "printf 'managed pip\\n'\n")
                self.env["PATH"] = str(self.home / "bin")
                result = self.run_command(
                    [
                        shutil.which("zsh"),
                        "-d",
                        "-ic",
                        "python --version; pip --version",
                    ]
                )
                expected = (
                    ["managed python", "managed pip"]
                    if managed
                    else ["python3: --version", "python3: -m pip --version"]
                )
                self.assertEqual(result.stdout.splitlines(), expected)

    def test_new_links_are_installed_idempotently(self):
        for _ in range(2):
            self.run_dotbot()
            for source, target in (
                (".zshenv", ".zshenv"),
                (".zprofile", ".zprofile"),
                (".gitignore_global", ".config/git/ignore"),
                ("gh/config.yml", ".config/gh/config.yml"),
            ):
                path = self.home / target
                self.assertTrue(path.is_symlink())
                self.assertEqual(path.resolve(), ROOT / source)

    def test_install_defaults_work_from_another_directory(self):
        self.env.pop("XDG_CONFIG_HOME")
        self.env.pop("ZDOTDIR")
        self.stub_command("git", "exit 0\n")
        self.run_command(
            ["bash", str(ROOT / "install"), "--only", "link"], cwd=self.home
        )
        for source, target in (
            (".zshrc", ".zshrc"),
            ("nvim", ".config/nvim"),
            ("gh/config.yml", ".config/gh/config.yml"),
            (".gitignore_global", ".config/git/ignore"),
        ):
            self.assertEqual((self.home / target).resolve(), ROOT / source)

    def test_install_honors_xdg_and_zsh_directories(self):
        config = self.home / "config files"
        zdotdir = self.home / "zsh files"
        self.env["XDG_CONFIG_HOME"] = str(config)
        self.env["ZDOTDIR"] = str(zdotdir)
        self.stub_command("git", 'if [ "$1" = clone ]; then mkdir -p "$4"; fi\n')
        self.run_command(["bash", str(ROOT / "install")], cwd=self.home)
        for source, target in (
            (".zprofile", zdotdir / ".zprofile"),
            (".zshrc", zdotdir / ".zshrc"),
            ("nvim", config / "nvim"),
            ("gh/config.yml", config / "gh/config.yml"),
            (".gitignore_global", config / "git/ignore"),
        ):
            self.assertTrue(target.is_symlink())
            self.assertEqual(target.resolve(), ROOT / source)
        self.assertFalse((self.home / ".zshrc").exists())
        self.assertFalse((self.home / ".config").exists())
        local = zdotdir / ".zshrc.local"
        self.assertEqual(local.read_text(), (ROOT / ".zshrc.local.example").read_text())
        self.assertTrue((self.home / ".gitconfig.local").is_file())
        if shutil.which("zsh"):
            local.write_text("export EDITOR=custom-editor\n")
            for mode in ("-lic", "-ic"):
                with self.subTest(mode=mode):
                    result = self.run_command(
                        ["zsh", "-d", mode, "print -r -- $EDITOR"]
                    )
                    self.assertEqual(result.stdout.strip(), "custom-editor")

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
        self.stub_command("uname", "printf '%s\\n' \"$DOTFILES_TEST_PLATFORM\"\n")
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
            "Thumbs.db",
            "nested/Thumbs.db",
            "desktop.ini",
            "nested/Desktop.ini",
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

    def test_git_uses_shell_editor_and_allows_local_overrides(self):
        self.link(".gitconfig", ".gitconfig")
        self.env["GIT_CONFIG_GLOBAL"] = str(self.home / ".gitconfig")
        self.env.pop("GIT_EDITOR", None)
        self.env["TERM"] = "xterm-256color"
        self.env["EDITOR"] = "shell-editor"
        self.env["VISUAL"] = "shell-editor"
        result = self.run_command(["git", "var", "GIT_EDITOR"], cwd=self.home)
        self.assertEqual(result.stdout.strip(), "shell-editor")
        (self.home / ".gitconfig.local").write_text(
            "[core]\n\teditor = machine-editor\n"
        )
        result = self.run_command(["git", "var", "GIT_EDITOR"], cwd=self.home)
        self.assertEqual(result.stdout.strip(), "machine-editor")

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

    def test_nvim_wsl_clipboard_and_native_provider_selection(self):
        self.stub_command(
            "clip.exe",
            "from pathlib import Path\n"
            "import sys\n"
            '(Path.home() / "clipboard").write_bytes(sys.stdin.buffer.read())\n',
            interpreter=sys.executable,
        )
        self.stub_command(
            "powershell.exe",
            "from pathlib import Path\n"
            "import sys\n"
            'text = (Path.home() / "clipboard").read_bytes().decode("utf-16le")\n'
            'sys.stdout.buffer.write(text.replace("\\r\\n", "\\n").encode("utf-8"))\n',
            interpreter=sys.executable,
        )
        for mode in (
            "macos",
            "wsl",
            "headless",
            "missing",
            "win32yank",
            "wayland",
            "x11",
            "custom",
        ):
            with self.subTest(mode=mode):
                self.run_nvim("nvim_clipboard.lua", args=(mode,))

    @unittest.skipUnless(shutil.which("powershell.exe"), "requires Windows PowerShell")
    def test_wsl_paste_command_preserves_utf8_and_newlines(self):
        result = self.run_nvim("nvim_clipboard.lua", args=("command",))
        command = json.loads(result.stdout)
        for value, expected in (
            ("$null", ""),
            ("'no extra newline'", "no extra newline"),
            (
                (
                    "[string][char]0x4E2D + [char]0x6587 + "
                    '[char]::ConvertFromUtf32(0x1F680) + "`r`nnext`r`n"'
                ),
                "\u4e2d\u6587\U0001f680\nnext\n",
            ),
        ):
            with self.subTest(value=value):
                # Shadow the cmdlet; never read the actual Windows clipboard.
                script = (
                    f"function Get-Clipboard {{ param([switch]$Raw) return ({value}) }}; "
                    + command[-1]
                )
                result = self.run_command([*command[:-1], script], text=False)
                self.assertEqual(result.stdout, expected.encode("utf-8"))

    def test_nvim_explorer_navigation_shortcuts(self):
        self.run_nvim("nvim_explorer.lua", "snacks.nvim")

    def test_nvim_outline_opens_on_the_right_and_q_closes_lists(self):
        self.run_nvim("nvim_outline.lua")

    def test_nvim_completion_and_tab_priorities(self):
        for event in ("InsertEnter", "CmdlineEnter"):
            with self.subTest(event=event):
                result = self.run_nvim(
                    "nvim_completion.lua", "lazy.nvim", "blink.cmp", args=(event,)
                )
                self.assertIn("Completion checks passed", result.stdout)

    def test_nvim_lsp_servers_start_with_completion_capabilities(self):
        result = self.run_nvim(
            "nvim_lsp.lua", "lazy.nvim", "blink.cmp", "nvim-lspconfig"
        )
        self.assertIn("LSP checks passed", result.stdout)
