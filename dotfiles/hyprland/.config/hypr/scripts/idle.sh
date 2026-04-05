#!/usr/bin/env bash
SWAYLOCK=$(which swaylock)

exec swayidle -w \
    timeout 300  "exec $SWAYLOCK -f" \
    timeout 330  'hyprctl dispatch dpms off' \
    resume       'hyprctl dispatch dpms on' \
    timeout 1800 'systemctl suspend' \
    before-sleep "exec $SWAYLOCK -f" \
    after-resume 'sleep 2 && hyprctl dispatch dpms on && sleep 1 && hyprctl dispatch dpms on'
