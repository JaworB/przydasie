# 14-Best-Practices

Guidelines for writing robust daemon scripts.

## 1. Infinite Loop with Sleep

```bash
while true; do
    check_condition
    sleep 2  # Prevent CPU spinning
done
```

## 2. Track Previous State

```bash
local previous_state="unknown"
```

## 3. Use Local Variables

```bash
local current_value
```

## 4. Suppress Unnecessary Output

```bash
command 2>/dev/null
```

## 5. Handle Edge Cases

```bash
if [[ -f /path/to/file ]]; then
    # Handle file
else
    # Handle missing file
fi
```

## 6. Check Dependencies

```bash
if command -v required_command >/dev/null 2>&1; then
    echo "Found"
fi
```

## 7. Use Descriptive Names

```bash
# Good
enable_dock_mode()
lid_handler_daemon()

# Bad
func1()
do_something()
```

## 8. Comment Complex Logic

```bash
# Check if lid is open or closed
# grep -q returns 0 if found, 1 if not
```

## Related

- [[13-Event-Detection-Pattern]] - Previous: Event Detection Pattern
- [[15-Quick-Reference]] - Next: Quick Reference
