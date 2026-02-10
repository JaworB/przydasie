# 02-Functions

Functions group related commands into reusable blocks.

## Definition

```bash
function_name() {
    # Commands
}
```

## Key Concepts

- **Reusability**: Write once, call multiple times
- **Organization**: Group related commands logically
- **Local Scope**: Variables can be limited to function

## Examples from Scripts

### Daemon Function

```bash
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
            else
                enable_normal_mode
            fi
            previous_lid_state="$lid_state"
            previous_ac_state="$ac_state"
        fi

        sleep 2
    done
}
```

### Mode Configuration Functions

```bash
enable_dock_mode() {
    hyprctl keyword monitor "eDP-1, disable"
    hyprctl keyword monitor "DVI-I-1, 3440x1440@50.00, 0x0, 1"
}

enable_normal_mode() {
    hyprctl keyword monitor "DVI-I-1, 3440x1440@50.00, 0x0, 1"
    hyprctl keyword monitor "eDP-1, preferred, 0x1440, 2"
}

fix_cursor_vertical() {
    hyprctl keyword monitor "DVI-I-1, 3440x1440@50.00, 0x0, 1"
    hyprctl keyword monitor "eDP-1, preferred, 0x1440, 2"
    hyprctl keyword cursor 1 1
    hyprctl keyword cursor 0 0
}
```

## Related

- [[01-Shebang]] - Previous: Shebang
- [[03-Variables]] - Next: Variables
