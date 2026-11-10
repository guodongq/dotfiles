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

```text
nvim/
├── init.lua
└── lua/
    ├── config/         options, keymaps, autocmds, VSCode Neovim keymaps
    └── plugins/
        ├── ui.lua      colors, statusline, tabs, file tree, pickers
        ├── editor.lua  Treesitter, motions, search and replace, sessions
        ├── lsp.lua     language servers, formatting, linting, completion
        └── ai.lua      Copilot suggestions and AI CLIs (sidekick.nvim)
```

To add a language, extend the tables at the top of `plugins/lsp.lua`.

| Key                         | Action                                  |
| --------------------------- | --------------------------------------- |
| `<Space>`                   | Leader; shows every key that follows it |
| `<leader>sf` / `<leader>sg` | Find files / search text                |
| `<leader>e`                 | File tree                               |
| `H` / `L`                   | Previous / next buffer                  |
| `<leader>R`                 | Search and replace across files         |
| `<leader>f`                 | Format (also runs on save)              |
| `<leader>xx`                | Diagnostics                             |
| `<C-/>`                     | Terminal                                |
| `<leader>aa` / `<leader>ac` | AI CLI / Copilot CLI                    |
| `<Tab>`                     | Apply the next edit suggestion          |
| `<leader>cp`                | Preview Markdown in the browser         |

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
