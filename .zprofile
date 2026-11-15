# Shared login environment; also loaded by non-login interactive shells.
typeset -U path PATH

for _brew in /opt/homebrew/bin/brew /usr/local/bin/brew /home/linuxbrew/.linuxbrew/bin/brew; do
  [[ -x $_brew ]] && eval "$("$_brew" shellenv)" && break
done
unset _brew

path+=("$HOME/.npm-global/bin" "$HOME/.local/bin")
