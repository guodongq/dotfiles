# Shared login environment; also loaded by non-login interactive shells.
typeset -U path PATH

# Homebrew on Apple Silicon, Intel macOS or Linux (WSL).
for _brew in "${commands[brew]:-}" \
  /opt/homebrew/bin/brew /usr/local/bin/brew \
  /home/linuxbrew/.linuxbrew/bin/brew "$HOME/.linuxbrew/bin/brew"; do
  [[ -x $_brew ]] && eval "$("$_brew" shellenv)" && break
done
unset _brew

# Personal tools win; ~/.npm-global/bin serves NPM_CONFIG_PREFIX (see .zshrc.local.example).
path=("$HOME/.local/bin" "$HOME/.npm-global/bin" $path)
