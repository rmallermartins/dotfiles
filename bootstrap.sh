#!/usr/bin/env bash

set -e

# Install gum
if ! command -v gum &> /dev/null; then
  ./scripts/install-gum.sh
fi

title() {
  gum style --border double  --padding "1 2" --foreground 212 --border-foreground 212 "$1"
}

text() {
  gum style --foreground 212 "$1"
}

spin() {
  local message="$1"
  shift
  gum spin --title "$message" -- "$@"
}

gum confirm "Init setup?" || exit 1

sudo apt update && sudo apt upgrade -y
text ">> System updated"

xargs -a packages.txt sudo apt install -y
./scripts/install-packages.sh
text ">> Packages installed"

stow -R .
text ">> Applied dotfiles"

mkdir -p ~/workspace

title "Finished setup!"
