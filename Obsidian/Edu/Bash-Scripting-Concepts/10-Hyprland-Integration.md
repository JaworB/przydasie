# 10-Hyprland-Integration

Control Hyprland window manager.

## hyprctl Commands

```bash
hyprctl keyword monitor "name, resolution@Hz, position, scale"
hyprctl keyword cursor x y
hyprctl monitors
```

## Examples from Scripts

```bash
# Disable monitor
hyprctl keyword monitor "eDP-1, disable"

# Configure external monitor
hyprctl keyword monitor "DVI-I-1, 3440x1440@50.00, 0x0, 1"

# Configure laptop monitor
hyprctl keyword monitor "eDP-1, preferred, 0x1440, 2"

# Recalibrate cursor
hyprctl keyword cursor 1 1
hyprctl keyword cursor 0 0

# List monitors
hyprctl monitors
```

## Command Breakdown

```bash
hyprctl keyword monitor "DVI-I-1, 3440x1440@50.00, 0x0, 1"
#              |       |       |        |        |  |
#              |       |       |        |        |  +-- scale: 1
#              |       |       |        |        +----- y: 0
#              |       |       |        +-------------- x: 0
#              |       |       +----------------------- refresh
#              |       +------------------------------ name
#              +------------------------------------- hyprland
```

## Related

- [[09-Logical-Operators]] - Previous: Logical Operators
- [[11-Sleep-and-Timing]] - Next: Sleep and Timing
