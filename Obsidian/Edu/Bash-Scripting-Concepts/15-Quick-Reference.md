# 15-Quick-Reference

Quick reference table for bash concepts.

## Concept Table

| Concept | Syntax | Purpose |
|---------|--------|---------|
| Shebang | `#!/bin/bash` | Interpreter |
| Function | `name() { }` | Reusable code |
| Local var | `local x="val"` | Scope control |
| If/else | `if [[ ]]; then; fi` | Conditionals |
| While loop | `while true; do; done` | Infinite loop |
| Command sub | `$(cmd)` | Capture output |
| Quiet grep | `grep -q` | Silent match |
| File test | `[[ -f file ]]` | Check exists |
| Background | `cmd &` | Async |
| AND | `&&` | Chain success |
| OR | `||` | Chain failure |
| Sleep | `sleep 2` | Delay |
| Redirect err | `2>/dev/null` | Suppress error |

## Common Patterns

### Daemon Pattern

```bash
while true; do
    check_condition
    perform_action
    sleep 2
done
```

### Toggle Pattern

```bash
state=false
toggle() {
    if $state; then
        action_a
        state=false
    else
        action_b
        state=true
    fi
}
```

### Event Detection Pattern

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

## Related

- [[14-Best-Practices]] - Previous: Best Practices
- [[index]] - Back to Index
