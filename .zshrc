# Shared shell settings. Machine-specific settings go in ~/.zshrc.local.
typeset -U path PATH # keep PATH entries unique

# Homebrew (Apple Silicon, Intel or Linux)
for _brew in /opt/homebrew/bin/brew /usr/local/bin/brew /home/linuxbrew/.linuxbrew/bin/brew; do
  [[ -x $_brew ]] && eval "$("$_brew" shellenv)" && break
done
unset _brew

# Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"
export ZSH_COMPDUMP="$HOME/.zcompdump" # the default name contains the hostname, which macOS changes
ZSH_THEME="bira"
plugins=(git)
fpath+=("$HOMEBREW_PREFIX/share/zsh-completions") # must be on fpath before compinit
[[ -r "$ZSH/oh-my-zsh.sh" ]] && source "$ZSH/oh-my-zsh.sh"

# More plugins. Order matters: syntax highlighting after autosuggestions and
# before history-substring-search, which binds the Up and Down keys.
for _plugin in \
  "$HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh" \
  "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" \
  "$ZSH/plugins/history-substring-search/history-substring-search.plugin.zsh"; do
  [[ -r $_plugin ]] && source "$_plugin"
done
unset _plugin

# Environment
export EDITOR=nvim VISUAL=nvim
export HERMES_TUI=1
path=("$HOMEBREW_PREFIX/opt/gnu-sed/libexec/gnubin" $path) # GNU sed instead of BSD sed
path+=("$HOME/.npm-global/bin" "$HOME/.local/bin")

# Aliases
alias vim=nvim vi=nvim
alias python=python3 pip=pip3
alias k=kubectl
[[ -f /etc/wsl.conf ]] && alias open=explorer.exe

# Last, so local settings win
if [[ -r "$HOME/.zshrc.local" ]]; then
  source "$HOME/.zshrc.local"
fi
