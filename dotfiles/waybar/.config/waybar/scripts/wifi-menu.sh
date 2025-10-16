#!/usr/bin/env bash
# ======================================================
# WiFi Menu para Wofi / Fuzzel - Hyprland Friendly
# ------------------------------------------------------
# Rápido, informativo e confiável
# - Detecta automaticamente Wayland display
# - Mostra sinal, segurança, SSID e IP atual
# - Permite refresh e desconexão
# - Usa fallback para fuzzel se wofi não disponível
# ======================================================

set -euo pipefail

# --- Ambiente gráfico (garante que wofi/fuzzel abre corretamente) ---
export XDG_CURRENT_DESKTOP=${XDG_CURRENT_DESKTOP:-Hyprland}
export XDG_SESSION_TYPE=${XDG_SESSION_TYPE:-wayland}
export DISPLAY=${DISPLAY:-:0}
export WAYLAND_DISPLAY=${WAYLAND_DISPLAY:-$(env | grep -m1 'WAYLAND_DISPLAY=' | cut -d= -f2 || echo "wayland-0")}

# --- Detecta interface Wi-Fi e estado atual ---
WIFI_IFACE=$(nmcli -t -f DEVICE,TYPE device status | awk -F: '$2=="wifi"{print $1; exit}')
[ -z "$WIFI_IFACE" ] && { notify-send "WiFi" "Nenhuma interface Wi-Fi encontrada" -i network-wireless-offline; exit 1; }

CURRENT_SSID=$(nmcli -t -f ACTIVE,SSID dev wifi | awk -F: '$1=="yes"{print $2}')
CURRENT_IP=$(nmcli -g IP4.ADDRESS device show "$WIFI_IFACE" | head -n1 | cut -d/ -f1)
SAVED_CONNECTIONS=$(nmcli -g NAME connection)

# --- Funções de ícones ---
get_signal_icon() {
    local s=$1
    if   [ "$s" -ge 80 ]; then echo "󰤨"
    elif [ "$s" -ge 60 ]; then echo "󰤥"
    elif [ "$s" -ge 40 ]; then echo "󰤢"
    elif [ "$s" -ge 20 ]; then echo "󰤟"
    else echo "󰤯"
    fi
}

get_security_icon() {
    local sec=$1
    [[ "$sec" != "--" && -n "$sec" ]] && echo "" || echo ""
}

# --- Lista de redes ---
TEMP_MAP=$(mktemp)
trap "rm -f '$TEMP_MAP'" EXIT

SSID_LIST="󰑐 Refresh Networks"
[ -n "$CURRENT_SSID" ] && SSID_LIST+="\n󰖂 Disconnect from $CURRENT_SSID ($CURRENT_IP)"

while IFS=: read -r ssid signal security; do
    [ -z "$ssid" ] && continue
    if echo "$SAVED_CONNECTIONS" | grep -Fxq "$ssid"; then
        icon=$(get_signal_icon "$signal")
        lock=$(get_security_icon "$security")

        if [ "$ssid" = "$CURRENT_SSID" ]; then
            choice="> $icon $lock $ssid  (Connected)"
        else
            choice="  $icon $lock $ssid"
        fi

        SSID_LIST+="\n$choice"
        echo "$choice|$ssid|$security" >> "$TEMP_MAP"
    fi
done < <(nmcli -t -f SSID,SIGNAL,SECURITY dev wifi list | sort -u)

SSID_LIST+="\n󰙅 Open WiFi Manager (nmtui)"

# --- Escolher menu (wofi → fuzzel fallback) ---
if command -v wofi &>/dev/null; then
    MENU_CMD="wofi --dmenu -p 'WiFi Networks:' --width 450 --lines 12 --cache-file /dev/null --matching contains --hide-scroll"
elif command -v fuzzel &>/dev/null; then
    MENU_CMD="fuzzel --dmenu --prompt 'WiFi Networks: '"
else
    notify-send "WiFi Menu" "Nem wofi nem fuzzel estão instalados." -i network-wireless-error
    exit 1
fi

CHOICE=$(echo -e "$SSID_LIST" | eval "$MENU_CMD")
[ -z "$CHOICE" ] && exit 0

# --- Ações ---
case "$CHOICE" in
    *"Refresh Networks"*)
        nmcli device wifi rescan
        exec "$0"
        ;;
    *"Disconnect from "*)
        nmcli device disconnect "$WIFI_IFACE"
        notify-send "WiFi" "Disconnected from $CURRENT_SSID" -i network-wireless-offline -t 3000
        ;;
    *"Open WiFi Manager (nmtui)"*)
        nmcli device wifi rescan
        kitty -e nmtui &
        ;;
    *)
        LINE=$(grep -F "$CHOICE|" "$TEMP_MAP" || true)
        SSID=$(echo "$LINE" | cut -d'|' -f2)
        [ -z "$SSID" ] && { notify-send "WiFi" "Erro: SSID não encontrado" -i network-wireless-error; exit 1; }

        if [ "$SSID" = "$CURRENT_SSID" ]; then
            notify-send "WiFi" "Já conectado em $SSID" -i network-wireless -t 2500
            exit 0
        fi

        if nmcli connection up "$SSID"; then
            NEW_IP=$(nmcli -g IP4.ADDRESS device show "$WIFI_IFACE" | head -n1 | cut -d/ -f1)
            notify-send "WiFi" "Conectado em $SSID ($NEW_IP)" -i network-wireless -t 3000
        else
            notify-send "WiFi" "Falha ao conectar em $SSID" -i network-wireless-error -t 5000
        fi
        ;;
esac
