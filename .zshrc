# ─────────────────────────────────────────────────────────────────────
# Interactive zsh configuration (symlinked to ~/.zshrc).
# Machine-private settings live in ~/.zshrc.local (see the example file);
# keep this tracked file portable.
#
# PATH is managed as the zsh `path` array; `typeset -U` drops duplicates.
# Prepend: path=("/dir" $path)   Append: path+=("/dir")
# ─────────────────────────────────────────────────────────────────────
typeset -U path PATH

# Homebrew (Apple Silicon / Intel / Linux, first match wins)
for _brew in /opt/homebrew/bin/brew /usr/local/bin/brew /home/linuxbrew/.linuxbrew/bin/brew; do
  [[ -x $_brew ]] && eval "$("$_brew" shellenv)" && break
done
unset _brew

# Oh My Zsh
export ZSH="${ZSH:-$HOME/.oh-my-zsh}"
export ZSH_CUSTOM="${ZSH_CUSTOM:-$ZSH/custom}"
# Pin the completion dump to a stable path; otherwise Oh My Zsh names it after
# the macOS LocalHostName, which drifts and forces a full compinit rebuild.
export ZSH_COMPDUMP="$HOME/.zcompdump"
ZSH_THEME="bira"
plugins=(git zsh-autosuggestions zsh-completions zsh-syntax-highlighting zsh-history-substring-search)
[[ -r "$ZSH/oh-my-zsh.sh" ]] && source "$ZSH/oh-my-zsh.sh"

# Editor
export EDITOR=nvim
export VISUAL=nvim

# PATH extras
# GNU sed ahead of the BSD sed that ships with macOS
[[ $OSTYPE == darwin* && -d "$HOMEBREW_PREFIX/opt/gnu-sed/libexec/gnubin" ]] && path=("$HOMEBREW_PREFIX/opt/gnu-sed/libexec/gnubin" "${path[@]}")
[[ -d "$HOME/.npm-global/bin" ]] && path+=("$HOME/.npm-global/bin")
[[ -d "$HOME/.local/bin" ]] && path+=("$HOME/.local/bin")

# Aliases
alias vim=nvim
alias vi=nvim
alias python=python3
alias pip=pip3
command -v kubectl &>/dev/null && alias k=kubectl
[ -f /etc/wsl.conf ] && alias open=explorer.exe

# Machine-specific language runtimes, private paths and secrets (untracked).
[[ -r "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"

# Hermes terminal UI
export HERMES_TUI=1
