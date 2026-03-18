#!/usr/bin/env bash
exec swayidle -w \
    timeout 300 'swaylock' \
    timeout 330 'hyprctl dispatch dpms off' \
    resume 'hyprctl dispatch dpms on' \
    timeout 1800 'systemctl suspend' \
    before-sleep 'swaylock' \
    after-resume 'hyprctl dispatch dpms on'
