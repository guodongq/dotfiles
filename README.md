# Dotfiles

Shared configuration for macOS (Apple Silicon and Intel) and WSL. Native
defaults come first; machine-specific settings and credentials stay out of Git.
There is one set of files, with platform checks only where needed.

## Install

The installer requires Git and Python 3. The shell configuration is for **zsh**,
not Bash. macOS includes zsh; on Ubuntu/Debian in WSL, install the basics first:

```sh
sudo apt update
sudo apt install git python3 zsh build-essential curl unzip
```

On macOS, install the Xcode command-line tools (`xcode-select --install`) if
Git or a C compiler is missing. Then, on either platform:

```sh
git clone https://github.com/guodongq/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install
```

`./install` runs [Dotbot](https://github.com/anishathalye/dotbot) with
`install.conf.yaml` and is safe to rerun. It:

- links the shell, Git, npm, GitHub CLI and Neovim configs, plus the iTerm2
  profile and VS Code Go snippets on macOS;
- clones Oh My Zsh and three zsh plugins when missing (it never updates them);
- copies the local shell and Git examples if missing.

Existing symlinks are replaced; regular files and directories are never
overwritten, so back them up and move them aside before rerunning. For links
only, without installing Oh My Zsh or copying examples, use `./install --only link`.
The Dotbot submodule is still initialized if missing.

The default locations are `~/.config` for application configs and `~` for zsh.
The installer also respects `XDG_CONFIG_HOME` and `ZDOTDIR`. If you customize
them, use absolute paths and keep them exported in future sessions too;
zsh must know `ZDOTDIR` before it looks for `.zshrc` (for example, set it in
`~/.zshenv`). Run the installer through `./install`, which supplies the defaults.

To make zsh your default shell, run `chsh -s "$(command -v zsh)"` and reopen
the terminal. The installer does not change your login shell. In WSL, keep
the checkout inside the Linux filesystem, such as `~/.dotfiles`, not `/mnt/c`.

## Local settings

Machine-specific settings go in `${ZDOTDIR:-$HOME}/.zshrc.local` and
`~/.gitconfig.local`.
They load last, so they win, and `./install` never touches them once they
exist. Set your Git name and email in `~/.gitconfig.local`. Shell-local settings
are for environment variables and aliases; Oh My Zsh has already loaded by
then, so they are not a place to choose its plugins or theme.

Git follows `VISUAL` / `EDITOR` instead of forcing a separate editor setting.
When Neovim is installed, zsh selects it; otherwise it preserves your existing
editor. To choose another editor, set both variables in `.zshrc.local`, or set
`core.editor` in `.gitconfig.local` for Git alone.

## Compatibility choices

| Area | Shared behavior and platform differences |
| --- | --- |
| Homebrew / PATH | Prefer `brew` already on PATH, then standard macOS/Linuxbrew locations. User binaries come before inherited tools; Windows PATH entries are kept for WSL interoperability. |
| Python | Keep an existing `python` or `pip` command. Only provide aliases when missing, so virtual environments and version managers are not shadowed. |
| npm | Use the official registry and the active Node installation's prefix. No shared `prefix` setting that conflicts with nvm/fnm/Volta. Existing `~/.npm-global/bin` stays on PATH; optional overrides are in `.zshrc.local.example`. |
| Git | Keep common Git preferences and local overrides. Ignore macOS and Windows file-manager noise, but not shared project settings such as `.vscode/settings.json`. |
| Neovim clipboard | macOS uses its built-in provider. WSL keeps win32yank, Wayland or X11 providers when available; otherwise it uses `clip.exe` / `powershell.exe`, handling Unicode and Windows line endings. Explicit `g:clipboard` settings are preserved. |
| Desktop apps | iTerm2 and macOS VS Code paths are linked only on macOS. WSL does not create `~/Library` or write into Windows user directories. |

## Layout

```text
.
├── install                 Dotbot bootstrap
├── install.conf.yaml       links and setup steps
├── .zprofile               login environment: Homebrew, PATH
├── .zshrc                  interactive shell: Oh My Zsh, editor, aliases
├── .gitconfig              Git preferences
├── .gitignore_global       OS/editor noise and private Claude settings
├── .npmrc                  npm registry; no forced global prefix
├── gh/                     GitHub CLI: `gh co` checks out a PR
├── iterm2/                 iTerm2 profile
├── vscode/                 VS Code settings and Go snippets
├── nvim/                   Neovim, see below
├── tests/                  behavior tests
└── dotbot/                 installer submodule
```

## Tools

`./install` sets up the shell, not development tools. For the same toolchain
on macOS and WSL, use [Homebrew](https://brew.sh/):

```sh
brew install neovim ripgrep fd tree-sitter-cli buf git-lfs gh node go
```

`fd` and `ripgrep` power file and text search, `tree-sitter-cli` builds parsers
(`tree-sitter` is only the library), `buf` formats Protobuf and `git-lfs` backs
the LFS filter in `.gitconfig`. Node.js and Go are also needed by the language
tools. Mason installs the other language servers, formatters and linters, not
their runtimes or a C compiler.

Use **Neovim 0.12+** on both systems. An older Ubuntu `apt` package will not
support all the native APIs used here; this is a version requirement, not a WSL
restriction. Keep one supported version rather than adding legacy API branches.

For a faster clipboard on WSLg, `sudo apt install wl-clipboard` enables
Neovim's built-in Wayland provider. Without WSLg, the Windows fallback requires
WSL interoperability and `clip.exe` / `powershell.exe` on PATH. The configuration
does not install Windows programs or re-enable interoperability for you.

## Desktop apps

- **iTerm2:** a [dynamic profile](https://iterm2.com/documentation-dynamic-profiles.html)
  named `Dotfiles` with Hack Nerd Font 16 pt (install the font yourself); other
  settings come from your default profile. Select it from the Profiles menu,
  and restart iTerm2 after editing `iterm2/profile.json`.
- **VS Code:** `vscode/settings.json` is a baseline to merge into your user
  settings by hand; it is not linked because local settings hold machine paths.
  Go snippets: `pln` for `fmt.Println`, `plf` for `fmt.Printf`.
- **WSL:** use Windows Terminal and VS Code's WSL extension. Install/select a
  Nerd Font in **Windows**, where the terminal UI runs, not just inside Linux.
  Merge the VS Code baseline with **Preferences: Open User Settings (JSON)**;
  import `vscode/snippets/go.json` with **Snippets: Configure Snippets**.
  Development tools and project files stay inside WSL.

## Neovim

Requires Neovim 0.12+ and a [Nerd Font](https://www.nerdfonts.com). Plugins and
Treesitter parsers install themselves on first use.

```text
nvim/
├── init.lua                load order and lazy.nvim bootstrap
└── lua/
    ├── options.lua         editor options and WSL clipboard fallback
    ├── keymaps.lua         editor keymaps
    ├── autocmds.lua        yank highlight, cursor restore, terminal mode
    └── plugins/
        ├── ui.lua          theme, explorer, pickers, indent guides, key hints
        ├── editor.lua      Treesitter, pairs, icons, indentation, completion
        ├── lsp.lua         language servers, formatting, linting
        └── ai.lua          Copilot suggestions and CLI
```

- Languages: C/C++, Go, Python, Markdown and JavaScript/TypeScript. To add one,
  update the lists in `plugins/lsp.lua`.
- Formatting runs on save (CLI tools, LSP fallback); linting on open and save.
- Diagnostics show as signs and underlines; `[d` / `]d` jump and show details.
- Run `:LspCopilotSignIn` once; `:Sidekick cli select` picks another AI CLI.
- `:Lazy sync` updates plugins; `:checkhealth` finds missing tools.

| Key | Action |
| --- | --- |
| `<Space>` | Leader; pause to see available keys |
| `<leader>sf` / `<leader>sg` | Find files / search text |
| `<leader>sw` | Search selection or current word |
| `<leader>sb` / `<leader>bd` | Find / close a buffer |
| `<leader>sd` | Diagnostics |
| `<leader>sh` / `<leader>sk` | Search help / keymaps |
| `<leader>e` | File explorer |
| `<leader>f` | Format |
| `H` / `L` | Previous / next buffer |
| `<C-h/j/k/l>` | Focus left / lower / upper / right window |
| `jk` (insert mode) | Leave insert mode |
| `<C-/>` | Toggle terminal |
| `<Esc><Esc>` (terminal mode) | Leave terminal mode |
| `<leader>ac` / `<leader>ap` | Copilot CLI / AI prompt with context |
| `gd` / `K` | Go to definition / hover |
| `grn` / `gra` / `grr` / `gO` | Rename / code action / references / symbols |

**Completion** (blink.cmp): `<CR>` accepts the selected item and `<C-n>` /
`<C-p>` move through items; command-line keys stay at Blink's defaults.
`<Tab>` never selects items: it jumps to the next snippet field (insert mode),
else jumps to or applies the next AI edit suggestion, else acts as usual.

**Explorer** (NERDTree-style): `o` / `l` / `<CR>` open, `h` collapses, `u` goes
up, `C` roots the tree at the selection, `R` refreshes and `?` lists all keys.

## Tests

```sh
python3 -m unittest discover -s tests -v
```

Tests use temporary home directories and stub network operations. They cover
both desktop platform branches, custom config directories, shell startup modes,
npm defaults, Git overrides and WSL clipboard Unicode/newline handling. They do
not read or write your real clipboard; the optional PowerShell check replaces
`Get-Clipboard` with a test function.

Neovim plugin tests use already-installed plugins and are skipped when those
are missing. Platform simulation is not a substitute for testing on a real Mac.
