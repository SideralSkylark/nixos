#!/usr/bin/env bash

OPTIONS="\
󰐥  Shutdown
󰑤  Reboot
󰒲  Suspend
󰍃  Logout"

CHOICE=$(echo "$OPTIONS" | tofi -c ~/.config/tofi/power.conf)

case "$CHOICE" in
  *Shutdown) systemctl poweroff ;;
  *Reboot) systemctl reboot ;;
  *Suspend) systemctl suspend ;;
  *Logout) hyprctl dispatch exit ;;
esac
