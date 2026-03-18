#!/usr/bin/env bash
TEMP=4000
is_active() {
    pgrep -x wlsunset >/dev/null && echo "on" || echo "off"
}
toggle() {
    if [ "$(is_active)" = "on" ]; then
        pkill -x wlsunset
    else
        wlsunset -t "$TEMP" -T 6500 &
    fi
    sleep 0.2
    pkill -RTMIN+8 waybar
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
