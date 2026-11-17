# Dotfiles

zsh, Git, Neovim and desktop-app configuration for macOS (Apple Silicon and
Intel) and WSL (Ubuntu). One set of files, with platform checks only where
needed; machine-specific settings and credentials stay out of Git.

## Install

You need Git, Python 3 and zsh. On macOS, run `xcode-select --install` if Git
or a C compiler is missing. On WSL (Ubuntu/Debian):

```sh
sudo apt update
sudo apt install git python3 zsh build-essential curl unzip
```

Then, on either platform:

```sh
git clone https://github.com/guodongq/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install
```

`./install` runs [Dotbot](https://github.com/anishathalye/dotbot) with
`install.conf.yaml` and is safe to rerun. It:

- links the shell, Git, GitHub CLI and Neovim configs, plus the iTerm2 profile
  and VS Code Go snippets on macOS, and removes dead links to deleted files;
- clones Oh My Zsh and three zsh plugins when missing (it never updates them);
- creates the local settings files from the examples when missing.

It replaces old symlinks but never overwrites regular files or directories;
move those aside and rerun. `./install --only link` only creates links.

Configs go to `~/.config` and zsh files to `~`, or to `$XDG_CONFIG_HOME` and
`$ZDOTDIR` when set. If you set them, use absolute paths and export them before
zsh starts, in every session.

The installer does not change your login shell: run `chsh -s "$(command -v zsh)"`
and reopen the terminal. On WSL, keep the checkout in the Linux filesystem, such
as `~/.dotfiles`, not under `/mnt/c`.

## Local settings

`${ZDOTDIR:-$HOME}/.zshrc.local` and `~/.gitconfig.local` hold machine-specific
settings. They load last, so they win, and `./install` never changes them once
they exist.

- **Git:** set your name and email here. Use `git config --file ~/.gitconfig.local`;
  `git config --global` would write into this repo through the `~/.gitconfig` link.
- **Shell:** environment variables and aliases. Oh My Zsh has already loaded, so
  this is not the place to choose its plugins or theme.
- **Editor:** Git follows `VISUAL` / `EDITOR`. zsh sets both to Neovim when it is
  installed and otherwise keeps your editor. Override both in `.zshrc.local`, or
  set `core.editor` in `.gitconfig.local` for Git alone.

## macOS and WSL

Both use the same files. The differences:

- **Homebrew and PATH:** `.zprofile` finds Homebrew on Apple Silicon, Intel or
  Linux. `~/.local/bin` and `~/.npm-global/bin` come first; on WSL, Windows PATH
  entries stay at the end for interoperability.
- **Shell:** `.zshenv` stops Ubuntu's `/etc/zsh/zshrc` from running `compinit`
  before Oh My Zsh does. Ubuntu has no `python`, so zsh aliases `python` and
  `pip` to Python 3, but only when those commands are missing; virtual
  environments and version managers still win.
- **Clipboard:** macOS uses Neovim's built-in provider. WSL uses win32yank,
  Wayland (`sudo apt install wl-clipboard` on WSLg) or X11 when available, and
  otherwise `clip.exe` / `powershell.exe` with Unicode and line endings handled;
  this needs WSL interoperability. An explicit `g:clipboard` always wins.
- **Browser:** Neovim previews open in the Windows browser on WSL.
- **Git over HTTPS:** macOS uses the Keychain; on WSL, enable the GitHub CLI
  helper in `~/.gitconfig.local` (see `.gitconfig.local.example`).
- **Desktop apps:** the iTerm2 profile and VS Code snippets are linked on macOS
  only. On WSL, use Windows Terminal and VS Code's WSL extension, install the
  Nerd Font in Windows, where the terminal runs, and keep tools and projects
  inside WSL.

## Layout

```text
.
├── install                 Dotbot bootstrap
├── install.conf.yaml       links and setup steps
├── .zshenv                 every zsh: skip Ubuntu's global compinit
├── .zprofile               login environment: Homebrew, PATH
├── .zshrc                  interactive shell: Oh My Zsh, editor, aliases
├── .gitconfig              Git preferences
├── .gitignore_global       OS and editor noise, private Claude settings
├── *.local.example         templates for the local settings
├── gh/                     GitHub CLI: `gh co` checks out a PR
├── iterm2/                 iTerm2 profile
├── vscode/                 VS Code settings and Go snippets
├── nvim/                   Neovim, see below
├── tests/                  behavior tests
└── dotbot/                 installer submodule
```

## Tools

`./install` sets up configs, not development tools. Install the same toolchain
on macOS and WSL with [Homebrew](https://brew.sh/):

```sh
brew install neovim ripgrep fd tree-sitter-cli buf git-lfs gh node go
brew install jupyterlab   # optional, for notebook previews
```

`ripgrep` and `fd` power search, `tree-sitter-cli` (not `tree-sitter`, the
library) builds parsers, `buf` formats Protobuf and `git-lfs` backs the LFS
filter in `.gitconfig`. Node.js and Go run language tools; Mason installs the
remaining language servers, formatters and linters, but not their runtimes or a
C compiler. npm keeps its defaults, so nvm, fnm and Volta work;
`.zshrc.local.example` shows how to set a mirror or a global prefix.

## Desktop apps

- **iTerm2:** a [dynamic profile](https://iterm2.com/documentation-dynamic-profiles.html)
  named `Dotfiles` with Hack Nerd Font 16 pt (install the font yourself); other
  settings come from your default profile. Select it in the Profiles menu and
  restart iTerm2 after editing `iterm2/profile.json`.
- **VS Code:** merge `vscode/settings.json` into your user settings by hand
  (**Preferences: Open User Settings (JSON)**); it is not linked because local
  settings hold machine paths. Go snippets: `pln` for `fmt.Println`, `plf` for
  `fmt.Printf`; on WSL, import them with **Snippets: Configure Snippets**.

## Neovim

Requires Neovim 0.12+ on both systems (Ubuntu's `apt` package is too old) and a
[Nerd Font](https://www.nerdfonts.com). Plugins, language tools and Treesitter
parsers install themselves on first use.

```text
nvim/
├── init.lua                load order and lazy.nvim bootstrap
└── lua/
    ├── options.lua         editor options and WSL clipboard fallback
    ├── keymaps.lua         editor keymaps
    ├── autocmds.lua        yank highlight, cursor restore, terminal mode
    ├── preview.lua         browser previews for Markdown and notebooks
    └── plugins/
        ├── ui.lua          theme, explorer, pickers, indent guides, key hints
        ├── editor.lua      Treesitter, pairs, icons, indentation, completion
        ├── lsp.lua         language servers, formatting, linting
        └── ai.lua          Copilot suggestions and CLI
```

- Languages: C/C++, Go, Lua, Python, Markdown and JavaScript/TypeScript. To add
  one, update the lists in `plugins/lsp.lua`.
- Formatting runs on save (CLI tools, LSP fallback); linting on open and save.
- Diagnostics show as signs and underlines; `[d` / `]d` jump and show details.
- Previews: Markdown through mpls; PlantUML diagrams use a local server at
  `127.0.0.1:8080`, never the public one. Notebooks open in JupyterLab: one
  server per project, stopped when Neovim exits. Save before previewing.
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
| `<leader>pp` / `<leader>pt` | Preview in browser / Markdown table of contents |
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

Tests use temporary home directories and stub the network, browser and Windows
commands, so they never touch your real clipboard. Neovim tests use the
installed plugins and are skipped when those are missing; the PowerShell check
runs only where `powershell.exe` exists.
