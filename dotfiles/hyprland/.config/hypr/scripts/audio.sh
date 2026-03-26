#!/usr/bin/env bash
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
        SUMMARY="󰍭 Mic muted"
    else
        ICON="󰍬"
        SUMMARY="󰍬 Mic active"
    fi
    notify-send \
        -a "system" \
        -u low \
        -t 1500 \
        -h string:x-canonical-private-synchronous:audio \
        -h int:value:0 \
        "$SUMMARY" ""
    exit 0
fi

if [[ $MUTED == "true" ]]; then
    ICON="󰖁"
    SUMMARY="󰖁 Muted"
    VOLUME=0
else
    if   (( VOLUME == 0 ));  then ICON="󰖁"
    elif (( VOLUME <= 33 )); then ICON="󰕿"
    elif (( VOLUME <= 66 )); then ICON="󰖀"
    else                          ICON="󰕾"
    fi
    SUMMARY="${ICON} Volume"
fi

notify-send \
    -a "system" \
    -u low \
    -t 1500 \
    -h string:x-canonical-private-synchronous:audio \
    -h int:value:$VOLUME \
    "$SUMMARY" "$VOLUME%"
