# ==========================
# Oh My Zsh
# ==========================
export ZSH="${ZSH:-$HOME/.oh-my-zsh}"
export ZSH_CUSTOM="${ZSH_CUSTOM:-$ZSH/custom}"
# Pin the completion dump to a stable path. Oh My Zsh otherwise names it after
# the macOS LocalHostName, which can change (DHCP/VPN/Bonjour renames), forcing
# a full (slow) compinit rebuild on every shell start instead of a cached load.
export ZSH_COMPDUMP="$HOME/.zcompdump"
ZSH_THEME="wuffers" # set by `omz`
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
# ngrok's completion script is static per-binary; cache it instead of forking
# `ngrok completion` on every shell start.
if (( $+functions[compdef] )) && command -v ngrok &>/dev/null; then
  __ngrok_comp_cache="${ZSH_CACHE_DIR:-$HOME/.cache}/ngrok_completion.zsh"
  __ngrok_bin="$(command -v ngrok)"
  if [ ! -s "$__ngrok_comp_cache" ] || [ "$__ngrok_bin" -nt "$__ngrok_comp_cache" ]; then
    mkdir -p "$(dirname "$__ngrok_comp_cache")"
    ngrok completion > "$__ngrok_comp_cache" 2>/dev/null
  fi
  source "$__ngrok_comp_cache"
  unset __ngrok_comp_cache __ngrok_bin
fi
[ -f "$HOME/.openclaw/completions/openclaw.zsh" ] && source "$HOME/.openclaw/completions/openclaw.zsh"

# Machine-specific language runtimes and paths belong in this untracked file.
[ -r "$HOME/.zshrc.local" ] && source "$HOME/.zshrc.local"

export HERMES_TUI=1
