# Dotfiles

Small configuration for zsh, Git, Neovim and a few desktop apps. Native
defaults come first; machine-specific settings and credentials stay out of Git.

## Install

Requires Git and Python 3.

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
- copies the examples to `~/.zshrc.local` and `~/.gitconfig.local` if missing.

Existing symlinks are replaced; regular files and directories are never
overwritten, so move them aside and rerun.

## Local settings

Machine-specific settings go in `~/.zshrc.local` and `~/.gitconfig.local`.
They load last, so they win, and `./install` never touches them once they
exist. Set your Git name and email in `~/.gitconfig.local`.

## Layout

```text
.
├── install                 Dotbot bootstrap
├── install.conf.yaml       links and setup steps
├── .zprofile               login environment: Homebrew, PATH
├── .zshrc                  interactive shell: Oh My Zsh, editor, aliases
├── .gitconfig              Git preferences
├── .gitignore_global       OS/editor noise and private Claude settings
├── .npmrc                  npm global prefix and registry
├── gh/                     GitHub CLI: `gh co` checks out a PR
├── iterm2/                 iTerm2 profile
├── vscode/                 VS Code settings and Go snippets
├── nvim/                   Neovim, see below
├── tests/                  behavior tests
└── dotbot/                 installer submodule
```

## Tools

`./install` sets up the shell, not development tools. With Homebrew:

```sh
brew install neovim ripgrep fd tree-sitter-cli buf git-lfs gh
```

`fd` and `ripgrep` power file and text search, `tree-sitter-cli` builds parsers
(`tree-sitter` is only the library), `buf` formats Protobuf and `git-lfs` backs
the LFS filter in `.gitconfig`. Mason installs the other language servers,
formatters and linters.

## Desktop apps

- **iTerm2:** a [dynamic profile](https://iterm2.com/documentation-dynamic-profiles.html)
  named `Dotfiles` with Hack Nerd Font 16 pt (install the font yourself); other
  settings come from your default profile. Select it from the Profiles menu,
  and restart iTerm2 after editing `iterm2/profile.json`.
- **VS Code:** `vscode/settings.json` is a baseline to merge into your user
  settings by hand; it is not linked because local settings hold machine paths.
  Go snippets: `pln` for `fmt.Println`, `plf` for `fmt.Printf`.

## Neovim

Requires Neovim 0.12+ and a [Nerd Font](https://www.nerdfonts.com). Plugins and
Treesitter parsers install themselves on first use.

```text
nvim/
├── init.lua                load order
└── lua/
    ├── config/             options, keymaps, autocmds, lazy.nvim bootstrap
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

Tests run in a temporary home directory without network access. Neovim tests
use your installed plugins and are skipped when those are missing.
