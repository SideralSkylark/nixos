#!/usr/bin/env bash

WALLPAPER_DIR="$HOME/Pictures/Wallpapers"
FILE=$(find "$WALLPAPER_DIR" -type f | shuf -n1)

# Inicializa daemon se não estiver a correr
if ! pgrep -x swww-daemon >/dev/null; then
    swww-daemon &
    # espera o socket criar
    sleep 1
fi

# Aplica wallpaper
swww img "$FILE" --transition-type fade --transition-duration 2
