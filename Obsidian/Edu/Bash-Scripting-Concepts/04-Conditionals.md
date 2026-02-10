# 04-Conditionals

Conditionals control script flow based on conditions.

## Test Brackets [[ ]]

```bash
# File tests
[[ -f /path/to/file ]]      # File exists
[[ -d /path/to/dir ]]       # Directory exists

# String tests
[[ "$var" == "value" ]]     # String equals
[[ "$var" != "value" ]]     # String not equals
[[ -z "$var" ]]             # Empty string
[[ -n "$var" ]]             # Non-empty string

# Numeric tests
[[ $num -eq 5 ]]            # Equal
[[ $num -gt 5 ]]            # Greater than
[[ $num -lt 5 ]]            # Less than
```

## If/Else Syntax

```bash
if condition; then
    commands
elif other_condition; then
    commands
else
    commands
fi
```

## Examples from Scripts

```bash
# File existence check
if [[ -f /proc/acpi/button/lid/LID/state ]]; then
    lid_state=$(cat /proc/acpi/button/lid/LID/state)
else
    lid_state="unknown"
fi

# Combined with AND
if [[ "$lid_state" == "closed" ]] && [[ "$ac_state" == "1" ]]; then
    enable_dock_mode
fi

# Nested conditionals
if [[ -f /proc/acpi/button/lid/LID/state ]]; then
    if grep -q "open" /proc/acpi/button/lid/LID/state 2>/dev/null; then
        lid_state="open"
    else
        lid_state="closed"
    fi
fi
```

## Related

- [[03-Variables]] - Previous: Variables
- [[05-Control-Flow]] - Next: Control Flow
