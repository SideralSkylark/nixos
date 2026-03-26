#!/usr/bin/env bash
TEMP=4000
HYPRSUNSET_CMD="hyprsunset -t $TEMP"

notify() {
    notify-send \
        -a "Reading Mode" \
        -u low \
        -t 3000 \
        "$1" "$2"
}

is_active() { pgrep -x hyprsunset >/dev/null; }

toggle() {
    if is_active; then
        pkill -x hyprsunset
        notify "󰃟 Reading Mode" "Manual OFF"
    else
        $HYPRSUNSET_CMD &
        notify "󰃞 Reading Mode" "Manual ON (${TEMP} K)"
    fi
    sleep 0.1
    pkill -RTMIN+8 waybar
}

case "$1" in
    toggle) toggle ;;
    display|"")
        if is_active; then
            printf '{"text":"󰃞","tooltip":"Reading Mode: ON (Manual)"}\n'
        else
            printf '{"text":"󰃟","tooltip":"Reading Mode: OFF / Auto"}\n'
        fi
        ;;
esac
