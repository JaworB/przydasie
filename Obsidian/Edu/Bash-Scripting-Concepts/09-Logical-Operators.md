# 09-Logical-Operators

Combine conditions and chain commands.

## AND Operator (&&)

```bash
command1 && command2
```

Run command2 ONLY if command1 succeeds.

## OR Operator (||)

```bash
command1 || command2
```

Run command2 ONLY if command1 fails.

## Examples from Scripts

```bash
# If-then-else pattern
grep -q "open" /proc/acpi/button/lid/LID/state 2>/dev/null && \
    lid_state="open" || \
    lid_state="closed"

# Chain commands
command1 && command2 && command3

# Error recovery
command1 || fallback_command

# Combined with conditionals
if [[ -f file ]] && cat file; then
    echo "Success"
fi
```

## Related

- [[08-Process-Management]] - Previous: Process Management
- [[10-Hyprland-Integration]] - Next: Hyprland Integration
