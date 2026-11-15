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
│       ├── config/         options, keymaps, autocmds
│       └── plugins/
│           ├── ui.lua      theme, pickers, key hints
│           ├── editor.lua  syntax, typing, completion
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

Existing symlinks may be replaced; regular files and directories are not.
Move conflicting paths aside and run `./install` again. Unrelated links,
application folders, other profiles and other snippets are left alone.

Oh My Zsh and three zsh plugins are installed only when their directories are
missing, never updated automatically. Plugins use `~/.oh-my-zsh/custom/plugins`,
or `$ZSH_CUSTOM/plugins` when set.

Machine-specific settings go in `~/.zshrc.local` and `~/.gitconfig.local`.
They load last and are never overwritten, including dangling symlinks.
New files start as commented examples; fill in your Git identity before committing.

`.zprofile` initializes Homebrew, a unique PATH and npm/pipx executables.
`.zshrc` sets the editor, aliases and shell plugins.
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
adds a `Dotfiles` profile with Hack Nerd Font at 16 pt. Other values inherit the
local default profile. Select it from the Profiles menu; installation does not
switch the active or default profile. Edit `iterm2/profile.json` to keep changes
in Git, and reopen iTerm2 if it does not notice a symlinked change.

**VS Code:** `vscode/settings.json` is a portable baseline, not automatically
linked. Merge wanted keys in the user settings editor instead of overwriting
local paths and provider settings. On a new machine, use it as initial settings.

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
| `<leader>f` | Format (also runs on save) |
| `<C-/>` | Terminal |
| `<leader>ac` | Copilot CLI |
| `<leader>ap` | AI prompts / file / selection context |
| `<Tab>` (normal mode) | Jump to / apply the next edit suggestion |

Completion uses `blink.cmp` in insert and command-line modes. In insert mode,
`<CR>` accepts the selected completion, or inserts a newline when none is selected.
`<Tab>` jumps to the next snippet field first, then tries an AI edit suggestion,
then falls back to the original key behavior; it does not select completions.
`<C-n>` / `<C-p>` select completion items. Command-line completion keeps Blink's
default keys, including `<Tab>` to show or cycle completions.

Use native `:w`, `:q` / `:qa` and `<C-w>` window commands.
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

Tests use temporary home directories and stub Git clones without network access,
covering shell startup, local overrides, idempotent installation, macOS-only links,
preservation of regular files and dangling local symlinks, and Git ignore rules.
Neovim checks cover explorer shortcuts, completion loading and Enter/Tab priority.
They use installed plugins and temporary data directories without downloads or
AI requests, and skip when Neovim or the required plugins are missing.
