# Dotfiles

Portable configuration for all the programs I use.
System-specific changes have their own branch.

## Installation

This repo uses [dotbot](https://github.com/anishathalye/dotbot/) for automatically linking the files.
On macOS, install Homebrew first; `./install` requires it to install `Brewfile`.
Git and Python 3 are also required for Dotbot.
Then clone and run `./install`.

```
git clone https://github.com/guodongq/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install
```

The installer will not overwrite a regular `~/.gitconfig` or `~/.config/nvim`
directory. Move either existing config aside yourself before rerunning it;
existing symlinks may be relinked. Homebrew or shell setup failures make
installation fail rather than silently skipping tools. The installer bootstraps
Oh My Zsh and its plugins at the revisions recorded in `install.conf.yaml`.
Machine-specific shell settings live in `~/.zshrc.local`; the installer creates
it from `.zshrc.local.example` when absent.

## Homebrew

`Brewfile` is the source of truth for CLI tools, taps, and casks; the installer
runs `brew bundle install` automatically on `./install`. Keep it in sync with
what's actually installed:

```
# After installing/removing something with brew, update the tracked file:
brew bundle dump --file=Brewfile --force --formula --cask

# Check drift without changing anything:
brew bundle check --file=Brewfile --verbose

# Remove anything installed but not listed in Brewfile (destructive, review first):
brew bundle cleanup --file=Brewfile
```

`--formula --cask` intentionally excludes `npm`/`go`/`uv`-installed global
packages that recent Homebrew Bundle versions also capture — those are managed
by their own toolchains, not Homebrew.

## Git

Shared settings (including the default identity) live in `.gitconfig`. Override
the identity for another machine, or store machine-only credentials, in an
untracked `~/.gitconfig.local` (copy `.gitconfig.local.example`); it is
`[include]`d last so its values win, and git silently ignores it when absent.
The example also shows `includeIf` for work/personal switching by repository
path. The Git LFS filter uses `git-lfs`, installed by `Brewfile`. Never commit
real tokens to this repo.

## Neovim

Config lives in `nvim/` (symlinked to `~/.config/nvim`). Standalone Neovim
requires 0.12 or later for the current `nvim-treesitter` branch. `init.lua`
loads editor settings, autocommands, and keymaps, then bootstraps
[lazy.nvim](https://github.com/folke/lazy.nvim); VSCode Neovim instead loads
the minimal `vscode.lua` integration. Plugin specs are grouped under
`lua/plugins/{ui,editor,lsp,finder}/` by concern. `keybinds.lua` owns editor
shortcuts; which-key describes their groups instead of being the sole source
of functional mappings.

Snacks handles search, the dashboard, and the terminal; nvim-tree remains the
file explorer (`<leader>e` / `<leader>E`). Mason installs configured LSP servers
and additional formatters/linters on first launch; nvim-lint uses `eslint_d`
for JavaScript/TypeScript and `markdownlint` for Markdown. Blink uses its
built-in snippet engine. Treesitter parsers are installed on first opening a
configured filetype; installation is asynchronous, so reopen that file after
its first install to activate highlighting. Run `:Lazy sync` to sync plugins
and `:checkhealth` to diagnose missing tools. Set
`vim.g.have_nerd_font = false` in `nvim/lua/settings.lua` if your terminal has
no Nerd Font.

### AI

[sidekick.nvim](https://github.com/folke/sidekick.nvim) provides inline Next
Edit Suggestions (`<Tab>` in normal mode; after Blink's snippet navigation in
insert mode) plus a terminal CLI toggle for tools like the Copilot CLI
(`<leader>a{a,c,s,d,p,f,t,v}`), backed by the `copilot` LSP server in
`plugins/lsp/servers.lua` (sign in with `:LspCopilotSignIn`).
