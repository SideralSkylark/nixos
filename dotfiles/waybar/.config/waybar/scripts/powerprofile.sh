#!/usr/bin/env bash
get_current_profile() {
    powerprofilesctl get 2>/dev/null || echo "balanced"
}

set_profile() {
    powerprofilesctl set "$1" 2>/dev/null || true
}

toggle_profile() {
    case "$(get_current_profile)" in
        power-saver)  set_profile balanced ;;
        balanced)     set_profile performance ;;
        performance)  set_profile power-saver ;;
        *)            set_profile balanced ;;
    esac
    pkill -RTMIN+9 waybar
}

icon_for() {
    case "$1" in
        power-saver)  printf "󰾆" ;;
        balanced)     printf "󰾅" ;;
        performance)  printf "󰓅" ;;
        *)            printf "󰾅" ;;
    esac
}

tooltip_for() {
    case "$1" in
        power-saver)  printf "Power Profile: Battery Saver\nOptimized for battery life" ;;
        balanced)     printf "Power Profile: Balanced\nPerformance and efficiency" ;;
        performance)  printf "Power Profile: Performance\nMaximum performance mode" ;;
        *)            printf "Power Profile: Balanced\nPerformance and efficiency" ;;
    esac
}

escape_json() {
    local s="$1"
    s="${s//\\/\\\\}"
    s="${s//\"/\\\"}"
    s="${s//$'\n'/\\n}"
    printf '%s' "$s"
}

case "${1:-}" in
    toggle)
        toggle_profile
        ;;
    *)
        cur=$(get_current_profile)
        et=$(escape_json "$(icon_for "$cur")")
        etool=$(escape_json "$(tooltip_for "$cur")")
        printf '{"text":"%s","tooltip":"%s"}\n' "$et" "$etool"
        ;;
esac
