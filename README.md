# Dotfiles

Small, readable configurations for the shell, development tools and desktop apps.
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

| File                | Linked to                 |
| ------------------- | ------------------------- |
| `.zprofile`         | `~/.zprofile`             |
| `.zshrc`            | `~/.zshrc`                |
| `.gitconfig`        | `~/.gitconfig`            |
| `.gitignore_global` | `~/.config/git/ignore`    |
| `gh/config.yml`     | `~/.config/gh/config.yml` |
| `.npmrc`            | `~/.npmrc`                |
| `nvim/`             | `~/.config/nvim`          |

On macOS, two individual files are also linked, without replacing their folders:

| File                      | Linked to                                                            |
| ------------------------- | -------------------------------------------------------------------- |
| `iterm2/profile.json`     | `~/Library/Application Support/iTerm2/DynamicProfiles/dotfiles.json` |
| `vscode/snippets/go.json` | `~/Library/Application Support/Code/User/snippets/go.json`           |

Zsh plugins live in `~/.oh-my-zsh/custom/plugins` (or `$ZSH_CUSTOM/plugins`).
Existing plugin directories are reused without pulling updates.

Machine-specific settings go in `~/.zshrc.local` and `~/.gitconfig.local`.
They are not tracked and are loaded last. Existing local files are preserved;
new ones start as commented examples. Fill in your Git identity before committing.

## Keep the layers small

- **Shared behavior:** tracked files above and explicit macOS preferences.
- **Machine-specific:** Git identity, private paths, aliases and environment
  variables stay in the existing `*.local` files, outside this repository.
- **Application state and credentials:** do not copy SSH keys, cloud credentials,
  CLI login stores, shell history, caches or entire application preference folders.

`.zprofile` initializes Homebrew, a unique PATH, GNU sed, npm/pipx executables and
optional OrbStack integration. `.zshrc` handles the interactive shell and loads
`.zprofile` only for non-login shells, so login terminals do not initialize twice.
Local interactive overrides still load last.

Git's standard global ignore file filters Finder files, editor temporary files
and private Claude settings. Project `.vscode/`, `.idea/` and shared Claude
settings are deliberately not globally ignored.

GitHub CLI keeps only the `gh co` checkout alias; native defaults supply the
other preferences. Authentication in `hosts.yml` stays outside this repository.

## Desktop preferences

**iTerm2:** the [dynamic profile](https://iterm2.com/documentation-dynamic-profiles.html)
adds a `Dotfiles` profile with the existing Hack Nerd Font at 16 pt. Unspecified
values inherit the local default profile, so commands, working directories and
other profiles are not copied or replaced. Select `Dotfiles` from the Profiles
menu when desired; installation does not switch the active or default profile.
Edit `iterm2/profile.json` to keep changes in Git. Reopen iTerm2 if it does not
notice a change through the symlink.

**Editors:** these are small portable baselines, not automatically linked:

| File                   | Preferences                                                   |
| ---------------------- | ------------------------------------------------------------- |
| `vscode/settings.json` | Editing, quiet UI, Go/Python/Markdown and Copilot suggestions |
| `cursor/settings.json` | Diff display, repository discovery and icon themes            |
| `zed/settings.json`    | Fonts, theme, autosave and HTML formatting                    |

For an existing installation, merge the wanted keys in the application's user
settings editor; do not overwrite the whole file. Existing settings also contain
interpreter paths, remote connections or provider configuration. On a new
machine, the matching baseline can be used as the initial `settings.json`.
No custom merge program or extra local-override convention is needed.

The Go snippets are managed separately: `pln` inserts `fmt.Println`, and `plf`
inserts `fmt.Printf`. Other snippets are left alone.

Fonts and themes are referenced, not bundled. Install Hack Nerd Font, JetBrains
Mono and the selected theme extensions only in the applications you use.
VS Code's icon theme is `chadalen.vscode-jetbrains-icon-theme`.

Native defaults are intentionally omitted. For example, Zed already supplies
the [Go inlay hints](https://zed.dev/docs/languages/go#inlay-hints); there is no
need to repeat them. Let each platform choose its terminal shell rather than
pinning a Windows executable path in shared settings.

SSH hosts, Copilot/Codex login or trust state, proxy accounts and application
history stay local. Default-only or empty configurations are not collected.

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

To add a language, update the server list and the relevant formatter, linter
and tool lists in `plugins/lsp.lua`. Each plugin keeps its options together.

Custom shortcuts focus on everyday actions. Use native `:w` to save, `:q` / `:qa`
to quit, and `<C-w>s` / `<C-w>v` / `<C-w>c` / `<C-w>o` to split, close or keep
only the current window.

| Key                         | Action                                  |
| --------------------------- | --------------------------------------- |
| `<Space>`                   | Leader; shows every key that follows it |
| `<leader>sf` / `<leader>sg` | Find files / search text                |
| `<leader>sw`                | Search selection / current word         |
| `<leader>sb` / `<leader>bd` | Find / close a buffer                   |
| `<leader>sd`                | Diagnostics picker                      |
| `<leader>sh` / `<leader>sk` | Search help / current keymaps           |
| `<leader>e`                 | File browser                            |
| `H` / `L`                   | Previous / next buffer                  |
| `<leader>f`                 | Format (also runs on save)              |
| `<C-/>`                     | Terminal                                |
| `<leader>ac`                | Copilot CLI                             |
| `<leader>ap`                | AI prompts / file / selection context   |
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

`./install` sets up shell plugins, not development tools. Homebrew is optional.
Install the shared tools directly when needed; no Brewfile is required:

```sh
brew install neovim ripgrep fd tree-sitter-cli buf git-lfs gnu-sed gh
```

`tree-sitter-cli` supplies the parser-building executable (`tree-sitter` is only
the library), `buf` formats `.proto` files, `git-lfs` supports the Git filters, and
`gnu-sed` provides the preferred `sed`. `gh` handles GitHub operations; `fd` and
`ripgrep` support file and text search. Mason installs the other configured
language servers, formatters and linters.

Install project-specific tools and GUI applications only as needed. Zsh plugins
already come from the Git checkouts managed by Dotbot, so a second Homebrew
installation is not needed for this setup.

## macOS

```sh
./macos/defaults.sh
```

This opt-in script records five existing preferences: key repeat instead of the
accent picker, no recent apps in the Dock, the scale minimize effect, Finder
column view and tap-to-click. It does not change security settings, remap
shortcuts, rearrange the Dock or restart applications. Some changes require a
new login. It is never run by `./install`.

## Checks

```sh
python3 -m unittest discover -s tests -v
```

Tests use temporary home directories to check shell startup modes, local
overrides, idempotent links, macOS-only desktop links, preservation of existing
files and Git ignore rules.
