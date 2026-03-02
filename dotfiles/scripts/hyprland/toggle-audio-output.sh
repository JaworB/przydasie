#!/bin/bash
AIRPODS="bluez_output.40:DA:5C:54:3D:E3"
SPEAKERS="alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__Speaker__sink"

CURRENT=$(pactl get-default-sink)

if [[ "$CURRENT" == "$AIRPODS" ]]; then
    pactl set-default-sink "$SPEAKERS"
    notify-send "Audio" "Switched to speakers" -t 1500
else
    pactl set-default-sink "$AIRPODS"
    notify-send "Audio" "Switched to AirPods" -t 1500
fi
