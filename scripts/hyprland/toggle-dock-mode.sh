#!/bin/bash

current_dock_mode=false

toggle_dock_mode() {
    if $current_dock_mode; then
        hyprctl keyword monitor "DVI-I-1, 3440x1440@50.00, 0x0, 1"
        hyprctl keyword monitor "eDP-1, preferred, 0x1440, 2"
        current_dock_mode=false
    else
        hyprctl keyword monitor "eDP-1, disable"
        hyprctl keyword monitor "DVI-I-1, 3440x1440@50.00, 0x0, 1"
        current_dock_mode=true
    fi
}

toggle_dock_mode
