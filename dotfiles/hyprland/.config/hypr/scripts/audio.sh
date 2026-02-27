#!/usr/bin/env bash
# export PATH="/run/current-system/sw/bin:/etc/profiles/per-user/$USER/bin:$PATH"

ACTION=$1

case $ACTION in
  up)   pamixer -i 10 ;;
  down) pamixer -d 10 ;;
  mute) pamixer -t ;;
  mic)  pamixer --default-source -t ;;
esac

MUTED=$(pamixer --get-mute)
VOLUME=$(pamixer --get-volume)

if [[ $ACTION == "mic" ]]; then
  MIC_MUTED=$(pamixer --default-source --get-mute)
  if [[ $MIC_MUTED == "true" ]]; then
    ICON="󰍭"
    SUMMARY="Mic Muted"
  else
    ICON="󰍬"
    SUMMARY="Mic Active"
  fi
  notify-send -a "system" -h string:x-canonical-private-synchronous:volume \
    -h int:value:100 \
    "$ICON $SUMMARY" "" -t 1500
  exit 0
fi

if [[ $MUTED == "true" ]]; then
  ICON="󰖁"
  SUMMARY="Muted"
  VOLUME=0
else
  if   (( VOLUME == 0 ));   then ICON="󰖁"
  elif (( VOLUME <= 33 ));  then ICON="󰕿"
  elif (( VOLUME <= 66 ));  then ICON="󰖀"
  else                           ICON="󰕾"
  fi
  SUMMARY="Volume  $VOLUME%"
fi

notify-send -a "system" \
  -h string:x-canonical-private-synchronous:volume \
  -h int:value:$VOLUME \
  "$ICON $SUMMARY" "" -t 1500
