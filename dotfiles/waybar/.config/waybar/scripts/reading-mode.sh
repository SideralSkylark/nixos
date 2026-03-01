#!/usr/bin/env bash
TEMP=4000

is_active() {
    pgrep -x hyprsunset >/dev/null && echo "on" || echo "off"
}

toggle() {
    if [ "$(is_active)" = "on" ]; then
        pkill -x hyprsunset
    else
        hyprsunset -t "$TEMP" &
    fi
    sleep 0.2
}

case "$1" in
    toggle) toggle ;;
    display|"")
        if [ "$(is_active)" = "on" ]; then
            printf '{"text":"󰃞","tooltip":"Reading Mode: ON\\nClick to turn OFF"}\n'
        else
            printf '{"text":"󰃟","tooltip":"Reading Mode: OFF\\nClick to turn ON"}\n'
        fi
        ;;
esac
