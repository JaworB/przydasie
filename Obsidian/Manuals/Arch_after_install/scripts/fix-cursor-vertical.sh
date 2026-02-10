#!/bin/bash

fix_cursor_vertical() {
    hyprctl keyword monitor "DVI-I-1, 3440x1440@50.00, 0x0, 1"
    hyprctl keyword monitor "eDP-1, preferred, 0x1440, 2"
    hyprctl keyword cursor 1 1
    hyprctl keyword cursor 0 0
}

fix_cursor_vertical
