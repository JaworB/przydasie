# fix-cursor-vertical.sh

Recalibrates cursor position after monitors enter vertical stack configuration.

## Location

```
~/.local/bin/fix-cursor-vertical.sh
```

## Binding

```
SUPER + SHIFT + V
```

## Functionality

1. Reapplies monitor configuration
2. Resets cursor position to 1,1
3. Clears cursor position to 0,0

## When to Use

- Cursor stuck or not responding correctly
- After manual monitor reconfiguration
- Cursor tracking issues in vertical stack

## Source

```bash
#!/bin/bash

fix_cursor_vertical() {
    hyprctl keyword monitor "DVI-I-1, 3440x1440@50.00, 0x0, 1"
    hyprctl keyword monitor "eDP-1, preferred, 0x1440, 2"
    hyprctl keyword cursor 1 1
    hyprctl keyword cursor 0 0
}

fix_cursor_vertical
```

## Related

- [[index]] - Script index
- [[01-lid-handler-daemon]] - Lid state monitoring daemon
- [[02-toggle-dock-mode]] - Manual dock toggle
- [[04-toggle-audio-output]] - Audio output toggle
