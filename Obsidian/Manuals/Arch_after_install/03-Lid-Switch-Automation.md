---
created: 2026-02-08
tags: [automation, hyprland, scripting, power-management]
---

# Lid Switch Automation

## Overview
Automates monitor and power behavior when closing/opening laptop lid based on power source.

## Behavior Matrix

| Lid State | Power Source | Action |
|-----------|--------------|--------|
| Closed | AC Power | Disable eDP-1, make DVI-I-1 primary @50Hz |
| Closed | Battery | Suspend system |
| Open | Any | Restore dual-monitor setup |

## Monitor Configuration

### Monitor Layout (Normal Mode - Vertical Stack)
```
+------------------------+
|    DVI-I-1 (Top)       | 3440x1440@50Hz at 0x0
+------------------------+
|                        |
|      eDP-1 (Bottom)    | 3840x2160@60Hz at 0x1440
+------------------------+
```

### Dock Mode (Lid Closed + AC)
- **Resolution**: 3440x1440
- **Refresh Rate**: 50Hz
- **Position**: 0x0 (primary)
- **Laptop Screen**: Disabled

### Normal Mode (Lid Open)
- **DVI-I-1**: 3440x1440@50Hz, position 0x0 (top)
- **eDP-1**: 3840x2160@60Hz, position 0x1440 (below DVI-I-1), scale 2

Note: DisplayLink driver limits refresh rate to 50Hz maximum.

## Files

| File | Purpose |
|------|---------|
| `~/.local/bin/lid-handler-daemon.sh` | Background daemon monitoring lid state |
| `~/.local/bin/toggle-dock-mode.sh` | Manual toggle between dock/normal mode |
| `~/.local/bin/fix-cursor-vertical.sh` | Recalibrate cursor for vertical stacking |
| `~/.config/hypr/autostart.conf` | Launches daemon on Hyprland start |
| `~/.config/hypr/bindings.conf` | Keybinding for manual toggle |
| `~/.config/hypr/monitors.conf` | Monitor configuration |
| `~/.config/hypr/windows.conf` | Workspace to monitor mapping |

## Keybinding

**`SUPER + m`** - Toggle dock mode on/off

## Manual Commands

```bash
# Start daemon manually
~/.local/bin/lid-handler-daemon.sh &

# Toggle dock mode
~/.local/bin/toggle-dock-mode.sh

# Fix cursor for vertical stacking
~/.local/bin/fix-cursor-vertical.sh

# Restore dual monitors (vertical stack)
hyprctl keyword monitor "DVI-I-1, 3440x1440@50.00, 0x0, 1"
hyprctl keyword monitor "eDP-1, preferred, 0x1440, 2"
```

## Daemon Logic

```bash
# Pseudocode
while true:
    lid_state = read("/proc/acpi/button/lid/LID/state")
    on_ac = read("/sys/class/power_supply/AC/online")

    if lid_state == "closed" AND on_ac == "1":
        disable("eDP-1")
        set_primary("DVI-I-1", "3440x1440@50.00", "0x0")
    else:
        disable_all()
        enable("DVI-I-1", "3440x1440@50.00", "0x0")
        enable("eDP-1", "preferred", "0x1440", scale=2)

    sleep 2
```

## Testing

```bash
# Test lid detection
cat /proc/acpi/button/lid/LID/state

# Test AC detection
cat /sys/class/power_supply/AC/online

# Check daemon running
ps aux | grep lid-handler

# Verify monitor positions
hyprctl monitors | grep -E "at.*x|@.*Hz"
```

## Related
- [[02-DisplayLink-Dock-Setup]] - DisplayLink driver installation
