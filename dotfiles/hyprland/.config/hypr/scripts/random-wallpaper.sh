#!/usr/bin/env bash

WALLPAPER_DIR="$HOME/Pictures/Wallpapers"
FILE=$(find "$WALLPAPER_DIR" -type f | shuf -n1)

pkill wbg

wbg -s "$FILE" &
