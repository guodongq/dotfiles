# Shared login environment; also loaded by non-login interactive shells.
typeset -U path PATH

for _brew in /opt/homebrew/bin/brew /usr/local/bin/brew /home/linuxbrew/.linuxbrew/bin/brew; do
  [[ -x $_brew ]] && eval "$("$_brew" shellenv)" && break
done
unset _brew

if [[ -n ${HOMEBREW_PREFIX:-} && -d "$HOMEBREW_PREFIX/opt/gnu-sed/libexec/gnubin" ]]; then
  path=("$HOMEBREW_PREFIX/opt/gnu-sed/libexec/gnubin" $path)
fi
path+=("$HOME/.npm-global/bin" "$HOME/.local/bin")

if [[ -r "$HOME/.orbstack/shell/init.zsh" ]]; then
  source "$HOME/.orbstack/shell/init.zsh"
fi
