# 13-Event-Detection-Pattern

Detect state changes by comparing current vs previous value.

## Pattern

```bash
previous="unknown"
while true; do
    current=$(get_state)
    if [[ "$current" != "$previous" ]]; then
        handle_change
        previous="$current"
    fi
    sleep interval
done
```

## Examples from Scripts

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

        # Detect state changes
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

## Related

- [[12-Toggle-Pattern]] - Previous: Toggle Pattern
- [[14-Best-Practices]] - Next: Best Practices
