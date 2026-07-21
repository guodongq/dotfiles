# ==========================
# Oh My Zsh
# ==========================
export ZSH="${ZSH:-$HOME/.oh-my-zsh}"
export ZSH_CUSTOM="${ZSH_CUSTOM:-$ZSH/custom}"
ZSH_THEME="cloud"
plugins=(git zsh-autosuggestions zsh-completions zsh-syntax-highlighting zsh-history-substring-search)
if [ -r "$ZSH/oh-my-zsh.sh" ]; then
  source "$ZSH/oh-my-zsh.sh"
fi

# ==========================
# Editor
# ==========================
export EDITOR=nvim
export VISUAL=nvim

# ==========================
# Homebrew
# ==========================
if [ -x "/opt/homebrew/bin/brew" ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -x "/usr/local/bin/brew" ]; then
  eval "$(/usr/local/bin/brew shellenv)"
elif [ -d "/home/linuxbrew/.linuxbrew" ]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# ==========================
# GNU sed (macOS)
# ==========================
if [ "$(uname)" = "Darwin" ] && [ -d "$HOMEBREW_PREFIX/opt/gnu-sed/libexec/gnubin" ]; then
  export PATH="$HOMEBREW_PREFIX/opt/gnu-sed/libexec/gnubin:$PATH"
fi

# ==========================
# Node / npm
# ==========================
if [ -d "$HOME/.npm-global" ]; then
  export PATH="$PATH:$HOME/.npm-global/bin"
fi

# ==========================
# pipx / local bin
# ==========================
if [ -d "$HOME/.local/bin" ]; then
  export PATH="$PATH:$HOME/.local/bin"
fi

# ==========================
# Aliases
# ==========================
alias vim=nvim
alias vi=nvim
alias python=python3
alias pip=pip3
command -v kubectl &>/dev/null && alias k=kubectl
[ -f /etc/wsl.conf ] && alias open=explorer.exe

# ==========================
# Completions (conditional)
# ==========================
(( $+functions[compdef] )) && command -v ngrok &>/dev/null && eval "$(ngrok completion)"
[ -f "$HOME/.openclaw/completions/openclaw.zsh" ] && source "$HOME/.openclaw/completions/openclaw.zsh"

# Machine-specific language runtimes and paths belong in this untracked file.
[ -r "$HOME/.zshrc.local" ] && source "$HOME/.zshrc.local"
