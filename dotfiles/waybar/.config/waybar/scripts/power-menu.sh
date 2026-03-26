#!/usr/bin/env bash
OPTIONS="\
󰐥  Shutdown
󰑤  Reboot
󰒲  Suspend
󰍃  Logout"

CHOICE=$(echo "$OPTIONS" | fuzzel --dmenu \
  --lines=4 \
  --prompt="> ")

case "$CHOICE" in
  *Shutdown) systemctl poweroff ;;
  *Reboot)   systemctl reboot ;;
  *Suspend)  systemctl suspend ;;
  *Logout)   hyprctl dispatch exit ;;
esac
