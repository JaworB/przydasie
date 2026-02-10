# 12-Toggle-Pattern

State machine that alternates between two states.

## Pattern

```bash
current_state=false

toggle() {
    if $current_state; then
        # Action A
        current_state=false
    else
        # Action B
        current_state=true
    fi
}
```

## Examples from Scripts

```bash
current_dock_mode=false

toggle_dock_mode() {
    if $current_dock_mode; then
        # Restore dual monitors
        hyprctl keyword monitor "DVI-I-1, 3440x1440@50.00, 0x0, 1"
        hyprctl keyword monitor "eDP-1, preferred, 0x1440, 2"
        current_dock_mode=false
        echo "Switched to normal mode"
    else
        # Enable dock only
        hyprctl keyword monitor "eDP-1, disable"
        hyprctl keyword monitor "DVI-I-1, 3440x1440@50.00, 0x0, 1"
        current_dock_mode=true
        echo "Switched to dock mode"
    fi
}

toggle_dock_mode
```

## Related

- [[11-Sleep-and-Timing]] - Previous: Sleep and Timing
- [[13-Event-Detection-Pattern]] - Next: Event Detection Pattern
