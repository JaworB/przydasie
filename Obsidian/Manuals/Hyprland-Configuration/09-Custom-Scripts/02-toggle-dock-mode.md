# toggle-dock-mode.sh

Manual toggle for DisplayLink dock mode without waiting for lid changes.

## Location

```
~/.local/bin/toggle-dock-mode.sh
```

## Binding

```
SUPER + M
```

## Behavior

Toggles between:

**Dock Mode (DVI-I-1 only):**
```
eDP-1: disabled
DVI-I-1: 3440x1440@50.00, 0x0, 1
```

**Normal Mode (Dual display):**
```
DVI-I-1: 3440x1440@50.00, 0x0, 1
eDP-1: preferred, 0x1440, 2
```

## Source

```bash
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
```

## Related

- [[index]] - Script index
- [[01-lid-handler-daemon]] - Lid state monitoring daemon
- [[03-fix-cursor-vertical]] - Cursor recalibration
- [[04-toggle-audio-output]] - Audio output toggle
