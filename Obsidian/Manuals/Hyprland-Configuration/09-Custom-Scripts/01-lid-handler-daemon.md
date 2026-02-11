# Lid Switch Automation

Background daemon that monitors lid state and AC power to automatically switch display modes or suspend.

## Behavior

| Lid State | Power Source | Action |
|-----------|-------------|--------|
| Closed | AC Power | Enable dock mode (eDP-1 disabled) |
| Closed | Battery | Suspend system |
| Open | Any | Normal mode (both monitors active) |

## Location

```
~/.local/bin/lid-handler-daemon.sh
```

## Start/Stop

```bash
# Start daemon (on login via autostart.conf)
~/.local/bin/lid-handler-daemon.sh

# Restart daemon
killall lid-handler-daemon.sh && ~/.local/bin/lid-handler-daemon.sh

# Check if running
pgrep -f lid-handler-daemon.sh
```

## Monitor Configuration

### Normal Mode (Vertical Stack)
```
+------------------------+
|    DVI-I-1 (Top)       | 3440x1440@50Hz at 0x0
+------------------------+
|      eDP-1 (Bottom)    | 3840x2160@60Hz at 0x1440, scale 2
+------------------------+
```

### Dock Mode (Lid Closed + AC)
- **DVI-I-1**: 3440x1440@50Hz, position 0x0
- **eDP-1**: Disabled

Note: DisplayLink driver limits refresh rate to 50Hz maximum.

## Manual Commands

```bash
# Toggle dock mode
~/.local/bin/toggle-dock-mode.sh

# Fix cursor for vertical stacking
~/.local/bin/fix-cursor-vertical.sh

# Restore dual monitors (vertical stack)
hyprctl keyword monitor "DVI-I-1, 3440x1440@50.00, 0x0, 1"
hyprctl keyword monitor "eDP-1, preferred, 0x1440, 2"
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

## Source

```bash
#!/bin/bash

lid_handler_daemon() {
    local previous_lid_state="unknown"
    local previous_ac_state="unknown"

    while true; do
        local lid_state
        local ac_state

        if [[ -f /proc/acpi/button/lid/LID/state ]]; then
            if grep -q "open" /proc/acpi/button/lid/LID/state 2>/dev/null; then
                lid_state="open"
            else
                lid_state="closed"
            fi
        else
            lid_state="unknown"
        fi

        if [[ -f /sys/class/power_supply/AC/online ]]; then
            ac_state=$(cat /sys/class/power_supply/AC/online)
        else
            ac_state="unknown"
        fi

        if [[ "$lid_state" != "$previous_lid_state" ]] || [[ "$ac_state" != "$previous_ac_state" ]]; then
            if [[ "$lid_state" == "closed" ]] && [[ "$ac_state" == "1" ]]; then
                enable_dock_mode
            elif [[ "$lid_state" == "closed" ]] && [[ "$ac_state" != "1" ]]; then
                systemctl suspend
            else
                enable_normal_mode
            fi
            previous_lid_state="$lid_state"
            previous_ac_state="$ac_state"
        fi

        sleep 2
    done
}

enable_dock_mode() {
    hyprctl keyword monitor "eDP-1, disable"
    hyprctl keyword monitor "DVI-I-1, 3440x1440@50.00, 0x0, 1"
}

enable_normal_mode() {
    hyprctl keyword monitor "DVI-I-1, 3440x1440@50.00, 0x0, 1"
    hyprctl keyword monitor "eDP-1, preferred, 0x1440, 2"
}

lid_handler_daemon
```

## Related

- [[02-toggle-dock-mode]] - Manual dock toggle
- [[03-fix-cursor-vertical]] - Cursor recalibration
- [[04-toggle-audio-output]] - Audio output toggle
- [[index]] - Script index
