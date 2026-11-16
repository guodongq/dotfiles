# Dotfiles

Small configurations for everyday use. Prefer native defaults, keep each file
focused, and leave machine-specific settings and credentials outside Git.

## Layout

```text
.
├── install                 Dotbot bootstrap
├── install.conf.yaml       links and shell setup
├── .zprofile / .zshrc       login environment / interactive shell
├── .gitconfig / .npmrc      Git and npm preferences
├── gh/                     GitHub CLI alias
├── iterm2/                 dynamic terminal profile
├── vscode/                 settings baseline and Go snippets
├── nvim/
│   ├── init.lua            startup
│   └── lua/
│       ├── config/         options, keymaps, autocmds, lazy bootstrap
│       └── plugins/
│           ├── ui.lua      theme, browser, pickers, indent, key hints
│           ├── editor.lua  syntax, pairs, icons, indent, completion
│           ├── lsp.lua     servers, formatting, linting
│           └── ai.lua      Copilot suggestions and CLIs
├── tests/                  isolated behavior tests
└── dotbot/                 installer submodule
```

Git's global ignore file, `.gitignore_global`, filters Finder files, editor
temporary files and private Claude settings. Shared project `.vscode/`, `.idea/`
and Claude settings are not globally ignored.

## Install

Requires Git and Python 3.

```sh
git clone https://github.com/guodongq/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install
```

[Dotbot](https://github.com/anishathalye/dotbot) handles installation.
The complete link list and shell setup live in `install.conf.yaml`; `install`
only bootstraps Dotbot. Links cover the shell, Git, npm, GitHub CLI and Neovim.
On macOS, the iTerm2 profile and Go snippets are also linked.

Existing symlinks may be replaced; regular files and directories are kept —
move conflicts aside and rerun `./install`. Unrelated links and application
files are left alone.

Oh My Zsh and three zsh plugins install only when missing and are never
auto-updated.

Machine-specific settings go in `~/.zshrc.local` and `~/.gitconfig.local`.
They load last and are never overwritten, including dangling symlinks.
New files start as commented examples; fill in your Git identity before committing.

`.zprofile` initializes Homebrew, a unique PATH and npm/pipx executables.
`.zshrc` sets the editor, aliases (`vim`/`vi` → nvim, `python` → python3,
`k` → kubectl) and shell plugins.
It loads `.zprofile` only for non-login shells, avoiding duplicate initialization.
Application-specific exports and integrations belong in `~/.zshrc.local`.

GitHub CLI adds only `gh co` for pull request checkout. Authentication, SSH hosts,
CLI login or trust state, shell history and caches stay local.

## Tools

`./install` sets up shell plugins, not development tools. Homebrew is optional:

```sh
brew install neovim ripgrep fd tree-sitter-cli buf git-lfs gh
```

`tree-sitter-cli` builds parsers; `tree-sitter` alone is only the library.
`buf` formats Protobuf, `git-lfs` supports Git filters, and `fd` and `ripgrep`
support search. Mason installs the other configured language servers,
formatters and linters.

Install project-specific tools and GUI applications only as needed.

## Desktop preferences

**iTerm2:** the [dynamic profile](https://iterm2.com/documentation-dynamic-profiles.html)
adds a `Dotfiles` profile with Hack Nerd Font at 16 pt; other values inherit
the local default. Select it from the Profiles menu — installation never
switches your active profile. Edit `iterm2/profile.json` to keep changes in
Git; reopen iTerm2 to pick up symlinked edits.

**VS Code:** `vscode/settings.json` is a portable baseline, not linked
automatically. Merge wanted keys in the settings editor rather than
overwriting local paths; on a new machine, use it as the starting point.

Go snippets are `pln` for `fmt.Println` and `plf` for `fmt.Printf`.
Install Hack Nerd Font where needed; it is not bundled.

## Neovim

Requires Neovim 0.12+ and a [Nerd Font](https://www.nerdfonts.com).
Plugins and Treesitter parsers install themselves on first use.
The UI keeps native statusline, line numbers, indent guides and on-demand pickers;
no dashboard, buffer tabs or notification popups.

LSP support covers C/C++, Go, Python, Markdown and JavaScript/TypeScript.
Diagnostics combine language-server checks with Ruff, ESLint, Revive and
Markdownlint. Both C and C++ format with `clang_format` on save.

Formatting uses CLI tools first, with LSP fallback on save and `<leader>f`.
Go runs `goimports` before `gofumpt`. To add a language, update the server,
formatter, linter and tool lists in `plugins/lsp.lua`.

| Key | Action |
| --- | --- |
| `<Space>` | Leader; shows available keys |
| `<leader>sf` / `<leader>sg` | Find files / search text |
| `<leader>sw` | Search selection / current word |
| `<leader>sb` / `<leader>bd` | Find / close a buffer |
| `<leader>sd` | Diagnostics picker |
| `<leader>sh` / `<leader>sk` | Search help / current keymaps |
| `<leader>e` | File browser |
| `H` / `L` | Previous / next buffer |
| `<C-h/j/k/l>` | Focus left / lower / upper / right window |
| `jk` (insert mode) | Leave insert mode |
| `<leader>f` | Format (also runs on save) |
| `<C-/>` | Terminal |
| `<Esc><Esc>` (terminal mode) | Leave terminal mode |
| `<leader>ac` | Copilot CLI |
| `<leader>ap` | AI prompts / file / selection context |
| `<Tab>` (normal mode) | Jump to / apply the next edit suggestion |

Completion uses `blink.cmp` in insert and command-line modes. `<CR>` accepts
the selected item or inserts a newline; `<C-n>` / `<C-p>` cycle items. `<Tab>`
prefers snippet jumps, then AI edit suggestions, then its normal behavior — it
never selects completions. Command-line keys stay at Blink's defaults.

Use native `:w`, `:q` / `:qa` and `<C-w>` split commands; `<C-h/j/k/l>` only
moves window focus.
LSP keys are `gd` for definitions, `K` for hover, `grn` for rename, `gra` for
code actions, `grr` for references and `gO` for document symbols.
`[d` / `]d` jump between diagnostics and open details; diagnostics use signs
and underlines rather than messages beside the code.

The Snacks file browser uses `h` to collapse and `o` / `l` / `<CR>` to expand or
open in Neovim. `u` goes up, `C` roots at the selection (or a file's parent),
`R` refreshes and `?` shows help. These shortcuts are local to the browser.

In Markdown, `gO` opens the native heading outline.
`<CR>` jumps to a heading; `:q` closes it.

Sign in with `:LspCopilotSignIn`; use `:Sidekick cli select` for other AI tools.
`:Lazy sync` updates plugins; `:checkhealth` reports missing tools.

## Checks

```sh
python3 -m unittest discover -s tests -v
```

Tests use temporary home directories and stub Git clones without network
access, covering shell startup, local overrides, idempotent installation,
macOS-only links, regular-file preservation, dangling local symlinks, Git
ignore rules, and Neovim explorer shortcuts and completion priority. Neovim
checks use installed plugins with temporary data directories, skipping when
Neovim or plugins are missing.
