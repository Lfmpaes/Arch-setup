#!/usr/bin/env bash
set -euo pipefail

# Reset the terminal, wait briefly, then draw the banner
printf '\033c'
sleep 0.5

cat <<'BANNER'
.__   _____                                  .__     
|  |_/ ____\_____ ___________ _______   ____ |  |__  
|  |\   __\/     \\____ \__  \\_  __ \_/ ___\|  |  \ 
|  |_|  | |  Y Y  \  |_> > __ \|  | \/\  \___|   Y  \
|____/__| |__|_|  /   __(____  /__|    \___  >___|  /
                \/|__|       \/            \/     \/ 
                                                 
                    lfmparch                     
BANNER

# Update system packages quietly to ensure latest base
echo "Updating system packages..."
sudo pacman -Syu --noconfirm >/dev/null 2>&1

# Ensure git is available for AUR operations
if ! command -v git >/dev/null 2>&1; then
  echo "git not found; installing git."
  sudo pacman -S --noconfirm git
fi

# Install yay if missing so we can pull AUR packages later
echo "Checking for yay..."
if ! command -v yay >/dev/null 2>&1; then
  echo "Installing yay and prerequisites."
  sudo pacman -S --needed --noconfirm base-devel
  workspace="$(mktemp -d)"
  git clone https://aur.archlinux.org/yay.git "$workspace/yay"
  (
    cd "$workspace/yay"
    makepkg -si --noconfirm
  )
  rm -rf "$workspace"
  echo "yay installation complete."
else
  echo "yay already installed; skipping."
fi
