# Dotfiles

Small, readable configurations for Zsh, Git and standalone Neovim.
Prefer native defaults; keep only everyday behavior here.

## Install

Requires Git and Python 3.

```sh
git clone https://github.com/guodongq/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install
```

[Dotbot](https://github.com/anishathalye/dotbot) reads `install.conf.yaml` to link
the files below, install Oh My Zsh and three zsh plugins, and create the local files.
`install` only bootstraps Dotbot; keep installation steps in the YAML configuration.
It replaces existing symlinks, but not regular files or directories; move
conflicting paths aside and run `./install` again. It does not clean up other
links in your home directory.

| File         | Linked to        |
| ------------ | ---------------- |
| `.zshrc`     | `~/.zshrc`       |
| `.gitconfig` | `~/.gitconfig`   |
| `.npmrc`     | `~/.npmrc`       |
| `nvim/`      | `~/.config/nvim` |

Zsh plugins live in `~/.oh-my-zsh/custom/plugins` (or `$ZSH_CUSTOM/plugins`).
Existing plugin directories are reused without pulling updates.

Machine-specific settings go in `~/.zshrc.local` and `~/.gitconfig.local`.
They are not tracked and are loaded last. Existing local files are preserved;
new ones start as commented examples. Fill in your Git identity before committing.

## Neovim

Standalone Neovim for the terminal. Requires Neovim 0.12+ and a
[Nerd Font](https://www.nerdfonts.com). Plugins, language servers, formatters and
Treesitter parsers install themselves on first use.

Code-first UI: native statusline, absolute line numbers, indent guides and
on-demand pickers. No dashboard, buffer tabs or notification popups.

```text
nvim/
├── init.lua
└── lua/
    ├── config/         options, keymaps, autocmds
    └── plugins/
        ├── ui.lua      theme, file browser, pickers, key hints
        ├── editor.lua  Treesitter, autopairs, icons, indentation
        ├── lsp.lua     language servers, formatting, linting, completion
        └── ai.lua      Copilot suggestions and AI CLIs (sidekick.nvim)
```

To add a language, extend the tables at the top of `plugins/lsp.lua`.

Custom shortcuts focus on everyday actions. Use native `:w` to save, `:q` / `:qa`
to quit, and `<C-w>s` / `<C-w>v` / `<C-w>c` / `<C-w>o` to split, close or keep
only the current window.

| Key                         | Action                                  |
| --------------------------- | --------------------------------------- |
| `<Space>`                   | Leader; shows every key that follows it  |
| `<leader>sf` / `<leader>sg`   | Find files / search text                |
| `<leader>sw`                 | Search selection / current word         |
| `<leader>sb` / `<leader>bd`   | Find / close a buffer                   |
| `<leader>sd`                 | Diagnostics picker                      |
| `<leader>sh` / `<leader>sk`   | Search help / current keymaps           |
| `<leader>e`                  | File browser                            |
| `H` / `L`                   | Previous / next buffer                  |
| `<leader>f`                 | Format (also runs on save)              |
| `<C-/>`                     | Terminal                                |
| `<leader>ac`                 | Copilot CLI                             |
| `<leader>ap`                 | AI prompts / file / selection context    |
| `<Tab>`                     | Apply the next edit suggestion          |

LSP keys stay conventional: `gd` for definitions, `K` for hover, `grn` for rename,
`gra` for code actions, `grr` for references, `gO` for document symbols, and
`[d` / `]d` for diagnostics. Diagnostics use signs and underlines; jumping opens
the details instead of displaying messages beside the code. Files and diagnostics
share the Snacks picker. In the file browser, `h` collapses directories, and
`o` / `l` / `<CR>` expand directories or open files in the Neovim editor window.

The file browser keeps the former tree shortcuts: `u` goes up, `C` roots the tree
at the selected directory (or a file's parent), and `?` toggles help. Use `R` to
refresh. These keys are local to the tree; `u` still undoes edits elsewhere.

Use native motions and text objects instead of another jump/surround key system.
Session management, project replace and Markdown preview plugins are omitted.
Other AI tools remain available through `:Sidekick cli select`.

Sign in once with `:LspCopilotSignIn` for the AI features. `:Lazy sync` updates
plugins and `:checkhealth` reports missing tools.

## Tools

`./install` sets up shell plugins, not development tools. Homebrew is optional;
if you use it, install the development tools with:

```sh
brew install neovim ripgrep fd tree-sitter buf git-lfs gnu-sed
```

`tree-sitter` builds parsers, `buf` formats `.proto` files, `git-lfs` supports the
Git filters, and `gnu-sed` provides the preferred `sed`. Mason installs the other
configured language servers, formatters and linters. Install other tools as needed.
