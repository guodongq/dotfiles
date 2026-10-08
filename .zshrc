# Shared shell settings; machine-specific overrides belong in ~/.zshrc.local.
# Keep PATH entries unique, including those added by plugins or local settings.
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
plugins=(
  git
  zsh-autosuggestions
  zsh-completions
  zsh-syntax-highlighting
  zsh-history-substring-search
)
[[ -r "$ZSH/oh-my-zsh.sh" ]] && source "$ZSH/oh-my-zsh.sh"

# Application defaults
export EDITOR=nvim
export VISUAL=nvim
export HERMES_TUI=1

# Prefer GNU sed over macOS's BSD sed.
if [[ $OSTYPE == darwin* && -d "$HOMEBREW_PREFIX/opt/gnu-sed/libexec/gnubin" ]]; then
  path=("$HOMEBREW_PREFIX/opt/gnu-sed/libexec/gnubin" "${path[@]}")
fi
[[ -d "$HOME/.npm-global/bin" ]] && path+=("$HOME/.npm-global/bin")
[[ -d "$HOME/.local/bin" ]] && path+=("$HOME/.local/bin")

# Aliases
alias vim=nvim vi=nvim
alias python=python3 pip=pip3
command -v kubectl &>/dev/null && alias k=kubectl
[[ -f /etc/wsl.conf ]] && alias open=explorer.exe

# Load last so local settings can override shared defaults.
if [[ -r "$HOME/.zshrc.local" ]]; then
  source "$HOME/.zshrc.local"
fi
