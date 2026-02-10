# 05-Control-Flow

Control flow statements manage script execution order.

## While Loop (Daemon Pattern)

```bash
while true; do
    # Commands
    sleep 2
done
```

Creates infinite loop for daemons.

## For Loop

```bash
for i in 1 2 3 4 5; do
    echo "Iteration $i"
done

# Glob pattern
for file in *.txt; do
    echo "Processing $file"
done
```

## Until Loop

```bash
until [ condition ]; do
    # Repeat until true
done
```

## Examples from Scripts

```bash
# Daemon loop
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

## Related

- [[04-Conditionals]] - Previous: Conditionals
- [[06-Command-Substitution]] - Next: Command Substitution
