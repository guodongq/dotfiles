# Shared shell settings. Machine-specific settings go in ~/.zshrc.local.
# GUI terminals can start interactive shells without reading .zprofile.
if [[ ! -o login && -r "$HOME/.zprofile" ]]; then
  source "$HOME/.zprofile"
fi

# Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"
export ZSH_COMPDUMP="$HOME/.zcompdump" # the default name contains the hostname, which macOS changes
ZSH_THEME="bira"
# Keep history search after highlighting so its Up/Down bindings win.
plugins=(git zsh-autosuggestions zsh-syntax-highlighting history-substring-search)
fpath+=("${ZSH_CUSTOM:-$ZSH/custom}/plugins/zsh-completions/src") # before compinit
[[ -r "$ZSH/oh-my-zsh.sh" ]] && source "$ZSH/oh-my-zsh.sh"

# Environment
export EDITOR=nvim VISUAL=nvim

# Aliases
alias vim=nvim vi=nvim
alias python=python3 pip=pip3
alias k=kubectl

# Last, so local settings win
if [[ -r "$HOME/.zshrc.local" ]]; then
  source "$HOME/.zshrc.local"
fi
