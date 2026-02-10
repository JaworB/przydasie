# 08-Process-Management

Manage background processes.

## Background Processes

```bash
command &
```

Run command in background.

## Kill Processes

```bash
killall process_name    # Kill by name
pkill -f "pattern"     # Kill by pattern
kill PID               # Kill by PID
kill -9 PID            # Force kill
```

## Examples from Scripts

```bash
# Launch daemon in background
~/.local/bin/lid-handler-daemon.sh &

# Restart daemon
killall lid-handler-daemon.sh && ~/.local/bin/lid-handler-daemon.sh &

# Check status
ps aux | grep lid-handler-daemon
```

## Related

- [[07-Error-Handling]] - Previous: Error Handling
- [[09-Logical-Operators]] - Next: Logical Operators
