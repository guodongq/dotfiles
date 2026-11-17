# Shared shell settings. Machine-specific settings go in .zshrc.local.
# GUI terminals can start interactive shells without reading .zprofile.
if [[ ! -o login && -r "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi

# Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"
export ZSH_COMPDUMP="$HOME/.zcompdump" # one file, not one per host and zsh version
ZSH_THEME="bira"
# history-substring-search must load after zsh-syntax-highlighting.
plugins=(git zsh-autosuggestions zsh-syntax-highlighting history-substring-search)
fpath+=("${ZSH_CUSTOM:-$ZSH/custom}/plugins/zsh-completions/src") # before compinit
[[ -r "$ZSH/oh-my-zsh.sh" ]] && source "$ZSH/oh-my-zsh.sh"

# Editor and aliases
if (( $+commands[nvim] )); then
  export EDITOR=nvim VISUAL=nvim
  alias vim=nvim vi=nvim
fi
(( $+commands[python] )) || alias python=python3
(( $+commands[pip] )) || alias pip='python -m pip'
alias k=kubectl

# Last, so local settings win
if [[ -r "${ZDOTDIR:-$HOME}/.zshrc.local" ]]; then
  source "${ZDOTDIR:-$HOME}/.zshrc.local"
fi
