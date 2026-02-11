# toggle-audio-output.sh

Toggle between Bluetooth AirPods and internal speakers.

## Location

```
~/.local/bin/toggle-audio-output.sh
```

## Binding

```
SUPER + SHIFT + A
```

## Functionality

- Uses `pactl get-default-sink` to check current output
- Toggles between AirPods and Speakers
- Shows notification on switch

## Audio Devices

| Device | Sink |
|--------|------|
| AirPods | `bluez_output.40:DA:5C:54:3D:E3` |
| Speakers | `alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__Speaker__sink` |

## Source

```bash
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
```

## Related

- [[index]] - Script index
- [[01-lid-handler-daemon]] - Lid state monitoring daemon
- [[02-toggle-dock-mode]] - Manual dock toggle
- [[03-fix-cursor-vertical]] - Cursor recalibration
