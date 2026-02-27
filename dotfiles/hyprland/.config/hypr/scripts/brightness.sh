#!/usr/bin/env bash

ACTION=$1

case $ACTION in
  up)   brightnessctl set +5% ;;
  down) brightnessctl set 5%- ;;
esac

MAX=$(brightnessctl max)
CUR=$(brightnessctl get)
PERCENT=$(( CUR * 100 / MAX ))

if   (( PERCENT <= 25 )); then ICON="󰃞"
elif (( PERCENT <= 50 )); then ICON="󰃟"
elif (( PERCENT <= 75 )); then ICON="󰃠"
else                           ICON="󰃠"
fi

notify-send -a "system" \
  -h string:x-canonical-private-synchronous:brightness \
  -h int:value:$PERCENT \
  "$ICON Brightness  $PERCENT%" "" -t 1500
