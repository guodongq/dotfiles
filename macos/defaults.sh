#!/usr/bin/env bash

set -euo pipefail

if [[ $(uname -s) != Darwin ]]; then
  printf 'These preferences require macOS.\n' >&2
  exit 1
fi

defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
defaults write com.apple.dock show-recents -bool false
defaults write com.apple.dock mineffect -string scale
defaults write com.apple.finder FXPreferredViewStyle -string clmv
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true

printf 'Preferences saved. Some changes take effect after logging in again.\n'
