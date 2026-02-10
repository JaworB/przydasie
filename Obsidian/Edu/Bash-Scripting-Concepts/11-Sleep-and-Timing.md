# 11-Sleep-and-Timing

Add delays to scripts.

## Sleep Command

```bash
sleep 2          # 2 seconds
sleep 0.5        # 500 milliseconds
sleep 1m         # 1 minute
sleep 1h         # 1 hour
```

## Examples from Scripts

```bash
# Daemon polling interval
while true; do
    check_state
    sleep 2  # Wait 2 seconds
done
```

## Related

- [[10-Hyprland-Integration]] - Previous: Hyprland Integration
- [[12-Toggle-Pattern]] - Next: Toggle Pattern
