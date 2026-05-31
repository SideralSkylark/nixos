#!/usr/bin/env bash
OVERRIDE_TEMP=3500

notify() {
    notify-send -a "Reading Mode" -u low -t 3000 "$1" "$2"
}

is_manual_active() { pgrep -f "hyprsunset -t $OVERRIDE_TEMP" >/dev/null; }

toggle() {
    if is_manual_active; then
        pkill -f "hyprsunset -t $OVERRIDE_TEMP"
        systemctl --user start hyprsunset.service
        notify "󰃟 Reading Mode" "System Schedule Restored"
    else
        systemctl --user stop hyprsunset.service
        sleep 0.3
        hyprsunset -t $OVERRIDE_TEMP &
        notify "󰃞 Reading Mode" "Deep Focus ON (${OVERRIDE_TEMP}K)"
    fi
    sleep 0.1
    pkill -RTMIN+8 waybar
}

case "$1" in
    toggle) toggle ;;
    display|"")
        if is_manual_active; then
            printf '{"text":"󰃞","tooltip":"Reading Mode: Focus Override (%sK)"}\n' "$OVERRIDE_TEMP"
        else
            printf '{"text":"󰃟","tooltip":"Reading Mode: Nix Schedule Active"}\n'
        fi
        ;;
esac
