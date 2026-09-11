# Dotfiles

Portable configuration for all the programs I use.
System-specific changes have their own branch.

## Installation

This repo uses [dotbot](https://github.com/anishathalye/dotbot/) for automatically linking the files.
Just clone and run `./install`.

```
git clone https://github.com/guodongq/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install
```

The installer bootstraps Oh My Zsh and the configured plugins at the revisions
recorded in `install.conf.yaml`. Machine-specific shell settings live in
`~/.zshrc.local`; the installer creates it from `.zshrc.local.example` when it
is absent. Edit that local file for language runtimes, package paths, and other
machine-only settings.

## Git

Shared settings live in `.gitconfig`. Per-machine identity or tokens go in an
untracked `~/.gitconfig.local` (copy `.gitconfig.local.example`); it is
`[include]`d last so its values win, and git silently ignores it when absent.
The example also shows `includeIf` for automatic work/personal switching by
repository path.

## Neovim

Config lives in `nvim/` (symlinked to `~/.config/nvim`) and uses
[lazy.nvim](https://github.com/folke/lazy.nvim) for plugin management, grouped
under `lua/plugins/{ui,editor,lsp,finder}/` by concern. LSP servers and CLI
tools are installed automatically via `mason-tool-installer` on first launch —
no manual setup beyond `:Lazy sync`.

### AI

[sidekick.nvim](https://github.com/folke/sidekick.nvim) provides inline Next
Edit Suggestions (`<Tab>`) plus a terminal CLI toggle for tools like the
Copilot CLI (`<leader>a{a,c,s,d,p,f,t,v}`), backed by the `copilot` LSP server
in `plugins/lsp/servers.lua` (sign in with `:LspCopilotSignIn`).

