# Dotfiles

Shell, Git and Neovim configuration.

## Install

Requires Git, Python 3 and [Homebrew](https://brew.sh).

```sh
git clone https://github.com/guodongq/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install
```

[Dotbot](https://github.com/anishathalye/dotbot) links the files below,
installs Oh My Zsh and three zsh plugins, and creates the local files. It never
overwrites an existing file: move it aside and run `./install` again, which is
always safe.

| File         | Linked to        |
| ------------ | ---------------- |
| `.zshrc`     | `~/.zshrc`       |
| `.gitconfig` | `~/.gitconfig`   |
| `.npmrc`     | `~/.npmrc`       |
| `nvim/`      | `~/.config/nvim` |

Machine-specific settings go in `~/.zshrc.local` and `~/.gitconfig.local` (your
name, email and secrets). They start as copies of the `*.local.example` files,
are not tracked, and are loaded last.

## Neovim

Requires Neovim 0.12+ and a [Nerd Font](https://www.nerdfonts.com). Plugins,
language servers, formatters and Treesitter parsers install themselves on first
use.

Code-first UI: native statusline, absolute line numbers and on-demand pickers.
No dashboard, buffer tabs or notification popups.

```text
nvim/
├── init.lua
└── lua/
    ├── config/         options, keymaps, autocmds, VSCode Neovim keymaps
    └── plugins/
        ├── ui.lua      theme, file browser, pickers, key hints
        ├── editor.lua  Treesitter, autopairs, icons, indentation
        ├── lsp.lua     language servers, formatting, linting, completion
        └── ai.lua      Copilot suggestions and AI CLIs (sidekick.nvim)
```

To add a language, extend the tables at the top of `plugins/lsp.lua`.

Custom shortcuts focus on everyday actions. Use native `:w` to save, `:q` / `:qa`
to quit, and `<C-w>s` / `<C-w>v` / `<C-w>c` / `<C-w>o` to split, close or keep
only the current window. In VSCode, use the editor's built-in actions for these.

| Key                         | Action                                  |
| --------------------------- | --------------------------------------- |
| `<Space>`                   | Leader; shows every key that follows it  |
| `<leader>sf` / `<leader>sg`   | Find files / search text                |
| `<leader>sw`                 | Search selection / current word         |
| `<leader>sb` / `<leader>bd`   | Find / close a buffer                   |
| `<leader>sh` / `<leader>sk`   | Search help / current keymaps           |
| `<leader>e`                  | File browser                            |
| `H` / `L`                   | Previous / next buffer                  |
| `<leader>f`                 | Format (also runs on save)              |
| `<leader>xx`                 | Diagnostics picker                      |
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

## Packages

`./install` doesn't install these; `brew install` what you use. Neovim needs
`ripgrep`, `fd`, `tree-sitter` (to build parsers) and `buf` (to format `.proto`
files); Mason installs the rest.

- **Shell and editors**: bash, fd, gh, git-lfs, gnu-sed, lazygit, neovide,
  neovim, ripgrep, tree. Casks: iterm2, font-noto-color-emoji.
- **Languages and build tools**: bazel, buf, cmake, gcc, go, go-task, maven,
  mockery, node, pipx, pkgconf, tree-sitter, utf8proc, uv.
- **Cloud and containers**: act, argocd, awscli, flux, helm, istioctl,
  kubernetes-cli, terragrunt, trivy, veracode-cli. Casks: ngrok, orbstack.
- **Utilities**: brew-rmtree, cloc, cookiecutter, ffmpeg, grpcui, hf, mdbook,
  mkcert, tmux, vale. Casks: copilot-cli, db-browser-for-sqlite.
