# ==========================
# Oh My Zsh
# ==========================
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="cloud"
plugins=(git zsh-autosuggestions zsh-completions zsh-syntax-highlighting zsh-history-substring-search)
source "$ZSH/oh-my-zsh.sh"

# ==========================
# Editor
# ==========================
export EDITOR=nvim
export VISUAL=nvim

# ==========================
# Homebrew
# ==========================
if [ "$(uname)" = "Darwin" ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -d "/home/linuxbrew/.linuxbrew" ]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# ==========================
# Golang
# ==========================
if [ -n "$HOMEBREW_PREFIX" ] && [ -d "$HOMEBREW_PREFIX/opt/go/libexec" ]; then
  export GOROOT="$HOMEBREW_PREFIX/opt/go/libexec"
  export GOPATH="$HOME/Workspaces"
  export PATH="$PATH:$GOPATH/bin"
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
# pnpm
# ==========================
export PNPM_HOME="$HOME/Library/pnpm"
if [ -d "$PNPM_HOME" ]; then
  case ":$PATH:" in
    *":$PNPM_HOME:"*) ;;
    *) export PATH="$PNPM_HOME:$PATH" ;;
  esac
fi

# ==========================
# Java (macOS)
# ==========================
if [ "$(uname)" = "Darwin" ] && [ -d "$HOMEBREW_PREFIX/opt/openjdk/bin" ]; then
  export PATH="$HOMEBREW_PREFIX/opt/openjdk/bin:$PATH"
  export CPPFLAGS="-I$HOMEBREW_PREFIX/opt/openjdk/include"
fi

# ==========================
# OpenBLAS
# ==========================
if [ -n "$HOMEBREW_PREFIX" ] && [ -d "$HOMEBREW_PREFIX/opt/openblas" ]; then
  export LDFLAGS="-L$HOMEBREW_PREFIX/opt/openblas/lib"
  export CPPFLAGS="${CPPFLAGS:+$CPPFLAGS }-I$HOMEBREW_PREFIX/opt/openblas/include"
  export PKG_CONFIG_PATH="$HOMEBREW_PREFIX/opt/openblas/lib/pkgconfig"
  export CMAKE_PREFIX_PATH="$HOMEBREW_PREFIX/opt/openblas"
fi

# ==========================
# pipx / local bin
# ==========================
if [ -d "$HOME/.local/bin" ]; then
  export PATH="$PATH:$HOME/.local/bin"
fi

# ==========================
# Conda
# ==========================
if [ -f "/opt/anaconda3/bin/conda" ]; then
  __conda_setup="$('/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2>/dev/null)"
  if [ $? -eq 0 ]; then
    eval "$__conda_setup"
  elif [ -f "/opt/anaconda3/etc/profile.d/conda.sh" ]; then
    . "/opt/anaconda3/etc/profile.d/conda.sh"
  fi
  unset __conda_setup
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
command -v ngrok &>/dev/null && eval "$(ngrok completion)"
[ -f "$HOME/.openclaw/completions/openclaw.zsh" ] && source "$HOME/.openclaw/completions/openclaw.zsh"
