# Dotfiles

Shared shell, Git and Neovim configuration. Keep machine-specific settings in
untracked local files rather than changing the shared defaults.

## Installation

Requires Git, Python 3 and Homebrew. On macOS, install Homebrew first.

```sh
git clone https://github.com/guodongq/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install
```

`./install` uses [Dotbot](https://github.com/anishathalye/dotbot/) to link configs,
installs `Brewfile`, checks out pinned Oh My Zsh dependencies, and creates
`~/.zshrc.local` if absent. Existing regular files/directories are not overwritten;
move conflicting configs aside before rerunning. Existing symlinks may be
relinked. Failed setup commands make installation fail.

## Where to change things

| Configuration                                       | File                                                   |
| --------------------------------------------------- | ------------------------------------------------------ |
| Shared shell defaults, aliases and plugins          | `.zshrc`                                               |
| Machine-only paths, runtimes and secrets            | `~/.zshrc.local` (start with `.zshrc.local.example`)   |
| Shared Git settings                                 | `.gitconfig`                                           |
| Git identity or machine-only overrides              | `~/.gitconfig.local` (copy `.gitconfig.local.example`) |
| Homebrew packages, grouped by purpose               | `Brewfile`                                             |
| Links, install steps and shell dependency revisions | `install.conf.yaml`                                    |
| Neovim options, keymaps and autocommands            | `nvim/lua/{settings,keybinds,autocmds}.lua`            |
| Neovim plugins                                      | `nvim/lua/plugins/{ui,editor,lsp,finder}/`             |

Local shell and Git files are loaded last, so their values override shared
defaults. Keep credentials out of tracked files. The Git example also shows
per-directory identities with `includeIf`.

## Homebrew

Edit `Brewfile` to add or remove packages, then install or check the list:

```sh
brew bundle install --file=Brewfile --no-lock
brew bundle check --file=Brewfile --verbose

# Remove unlisted packages (destructive; review first).
brew bundle cleanup --file=Brewfile
```

To regenerate from installed packages, use
`brew bundle dump --file=Brewfile --force --formula --cask`. This replaces the
manual grouping and excludes global `npm`/`go`/`uv` packages, which belong to
their own toolchains.

## Neovim

Requires Neovim 0.12+ for the current Treesitter branch. `nvim/` is linked to
`~/.config/nvim`; `init.lua` loads settings, autocommands, plugins and keymaps.
VSCode Neovim only loads `lua/vscode.lua`, leaving plugins and UI to VSCode.

Plugin files return a single Lazy spec; keep plugin-specific keymaps with that
spec and editor-only shortcuts in `keybinds.lua`. Which-key labels groups, not
functional mappings. To add a language, edit `servers` and `tools` in
`plugins/lsp/servers.lua`, then the filetype lists in `plugins/lsp/{format,lint}.lua`
and `plugins/editor/treesitter.lua` as needed.

Snacks handles search, dashboard and terminal; nvim-tree is the explorer
(`<leader>e` / `<leader>E`). Mason installs LSP servers and tools on first launch.
Blink uses built-in snippets. Treesitter installs parsers asynchronously on
first use; reopen the file afterward to enable highlighting.

Use `:Lazy sync` to sync plugins and `:checkhealth` for missing tools. Without
a Nerd Font, set `vim.g.have_nerd_font = false` in `lua/settings.lua`.

### AI

[sidekick.nvim](https://github.com/folke/sidekick.nvim) uses the `copilot` LSP
server for next-edit suggestions. Sign in with `:LspCopilotSignIn`; use `<Tab>`
to apply/jump (in insert mode, Blink snippet navigation takes precedence).
`<leader>aa` toggles the CLI and `<leader>ac` opens Copilot. Other AI shortcuts
live in `plugins/lsp/sidekick.lua` and appear in which-key.
