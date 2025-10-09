#!/usr/bin/env bash
set -euo pipefail

# Mirror key desktop and shell configuration files into the repository.
# Run from any location; files are placed relative to this script directory.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Map of source file -> destination file inside the repo.
declare -A FILE_BACKUPS=(
  ["$HOME/.zshrc"]="$SCRIPT_DIR/configs/zsh/.zshrc"
  ["$HOME/.p10k.zsh"]="$SCRIPT_DIR/configs/zsh/.p10k.zsh"
  ["$HOME/.config/konsolerc"]="$SCRIPT_DIR/configs/konsole/config/konsolerc"
  ["$HOME/.config/konsolesshconfig"]="$SCRIPT_DIR/configs/konsole/config/konsolesshconfig"
  ["$HOME/.local/share/konsole/Profile 1.profile"]="$SCRIPT_DIR/configs/konsole/profiles/Profile 1.profile"
  ["$HOME/.config/plasma-org.kde.plasma.desktop-appletsrc"]="$SCRIPT_DIR/configs/plasma/config/plasma-org.kde.plasma.desktop-appletsrc"
  ["$HOME/.config/plasmashellrc"]="$SCRIPT_DIR/configs/plasma/config/plasmashellrc"
  ["$HOME/.config/kdeglobals"]="$SCRIPT_DIR/configs/plasma/config/kdeglobals"
  ["$HOME/.config/kscreenlockerrc"]="$SCRIPT_DIR/configs/plasma/config/kscreenlockerrc"
  ["$HOME/.config/kglobalshortcutsrc"]="$SCRIPT_DIR/configs/plasma/config/kglobalshortcutsrc"
  ["$HOME/Pictures/Wallpapers/small-memory-lp-1920x1200.jpg"]="$SCRIPT_DIR/configs/plasma/wallpapers/small-memory-lp-1920x1200.jpg"
  ["$HOME/Pictures/Wallpapers/sunrise-landscape-minimalism-5k-ex-1920x1200.jpg"]="$SCRIPT_DIR/configs/plasma/wallpapers/sunrise-landscape-minimalism-5k-ex-1920x1200.jpg"
)

log() {
  printf '%s\n' "$1"
}

warn_missing() {
  printf 'Warning: %s not found, skipping.\n' "$1" >&2
}

for src in "${!FILE_BACKUPS[@]}"; do
  dest="${FILE_BACKUPS[$src]}"
  if [[ -f "$src" ]]; then
    mkdir -p "$(dirname "$dest")"
    cp -f "$src" "$dest"
    rel_dest="${dest#$SCRIPT_DIR/}"
    log "Saved ${rel_dest}"
  else
    warn_missing "$src"
  fi
done

log "Backup complete."
