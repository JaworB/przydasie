#!/bin/bash

STATE_DIR="$HOME/.local/state/omarchy/toggles/hypr"
STATE_FILE="$STATE_DIR/dock-mode.conf"
EXTERNAL_MONITOR="DVI-I-1"

mkdir -p "$STATE_DIR"

external_monitor_connected() {
    hyprctl monitors -j | jq -e --arg name "$EXTERNAL_MONITOR" '.[] | select(.name == $name)' >/dev/null 2>&1
}

enable_dock_mode() {
    if ! external_monitor_connected; then
        notify-send -u critical "󰍹 Dock mode" "External monitor ($EXTERNAL_MONITOR) not connected"
        exit 1
    fi
    hyprctl keyword monitor "eDP-1, disable"
    hyprctl keyword monitor "$EXTERNAL_MONITOR, 3440x1440@50.00, 0x0, 1"
    touch "$STATE_FILE"
}

enable_normal_mode() {
    hyprctl keyword monitor "$EXTERNAL_MONITOR, 3440x1440@50.00, 0x0, 1"
    hyprctl keyword monitor "eDP-1, preferred, 0x1440, 2"
    rm -f "$STATE_FILE"
}

toggle_dock_mode() {
    if [[ -f "$STATE_FILE" ]]; then
        enable_normal_mode
    else
        enable_dock_mode
    fi
}

toggle_dock_mode
