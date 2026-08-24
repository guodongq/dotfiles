typeset -U path PATH

# Homebrew
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
elif [[ -x /home/linuxbrew/.linuxbrew/bin/brew ]]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# Oh My Zsh
export ZSH="${ZSH:-$HOME/.oh-my-zsh}"
export ZSH_CUSTOM="${ZSH_CUSTOM:-$ZSH/custom}"
# Pin the completion dump to a stable path; otherwise Oh My Zsh names it after
# the macOS LocalHostName, which drifts and forces a full compinit rebuild.
export ZSH_COMPDUMP="$HOME/.zcompdump"
ZSH_THEME="bira" # set by `omz`
plugins=(git zsh-autosuggestions zsh-completions zsh-syntax-highlighting zsh-history-substring-search)
[[ -r "$ZSH/oh-my-zsh.sh" ]] && source "$ZSH/oh-my-zsh.sh"

# Editor
export EDITOR=nvim VISUAL=nvim

# PATH extras
[[ $OSTYPE == darwin* && -d "$HOMEBREW_PREFIX/opt/gnu-sed/libexec/gnubin" ]] && path=("$HOMEBREW_PREFIX/opt/gnu-sed/libexec/gnubin" "${path[@]}")
[[ -d "$HOME/.npm-global/bin" ]] && path+=("$HOME/.npm-global/bin")
[[ -d "$HOME/.local/bin" ]] && path+=("$HOME/.local/bin")

# Aliases
alias vim=nvim vi=nvim python=python3 pip=pip3
command -v kubectl &>/dev/null && alias k=kubectl
[ -f /etc/wsl.conf ] && alias open=explorer.exe

# Machine-specific language runtimes and paths belong in this untracked file.
[[ -r "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"

export HERMES_TUI=1
