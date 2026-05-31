#!/usr/bin/env bash

icon_for() {
    case "$1" in
        powersave)              echo "󰾆" ;;
        balanced)               echo "󰾅" ;;
        throughput-performance|\
        latency-performance|\
        performance)            echo "󰓅" ;;
        *)                      echo "󰾅" ;;
    esac
}

tooltip_for() {
    case "$1" in
        powersave)              echo "Tuned: Powersave" ;;
        balanced)               echo "Tuned: Balanced" ;;
        throughput-performance) echo "Tuned: Throughput Performance" ;;
        latency-performance)    echo "Tuned: Latency Performance" ;;
        *)                      echo "Tuned: $1" ;;
    esac
}

case "$1" in
    cycle)
        profiles=(powersave balanced throughput-performance)
        cur=$(tuned-adm active 2>/dev/null | awk -F': ' '{print $2}' | tr -d '[:space:]')
        for i in "${!profiles[@]}"; do
            if [[ "${profiles[$i]}" == "$cur" ]]; then
                next="${profiles[$(( (i+1) % ${#profiles[@]} ))]}"
                sudo tuned-adm profile "$next"
                pkill -RTMIN+9 waybar
                exit
            fi
        done
        ;;
    pick)
        chosen=$(printf '%s\n' powersave balanced throughput-performance | fuzzel --dmenu)
        [[ -n "$chosen" ]] && sudo tuned-adm profile "$chosen" && pkill -RTMIN+9 waybar
        ;;
    *)
        cur=$(tuned-adm active 2>/dev/null | awk -F': ' '{print $2}' | tr -d '[:space:]')
        printf '{"text":"%s","tooltip":"%s"}\n' "$(icon_for "$cur")" "$(tooltip_for "$cur")"
        ;;
esac
