#!/usr/bin/env bash

set -euo pipefail

WALLPAPER_DIR="$HOME/Pictures/Wallpapers"

FILE="$(
find "$WALLPAPER_DIR" \
  -type f \
  \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) |
shuf -n1
)"

# ensure we actually got a file
[ -n "$FILE" ] || exit 1

# wait until hyprland monitors are ready
while ! hyprctl monitors >/dev/null 2>&1; do
    sleep 0.1
done

# give outputs a moment to settle
sleep 0.5

# fully stop previous instance
pkill -x wbg 2>/dev/null || true

# wait for process death
while pgrep -x wbg >/dev/null; do
    sleep 0.1
done

exec wbg -s "$FILE"
