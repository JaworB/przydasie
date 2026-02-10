# 06-Command-Substitution

Command substitution captures command output for use in variables.

## Syntax

```bash
$(command)    # Modern
`command`      # Legacy
```

## Usage

```bash
# Capture output
ac_state=$(cat /sys/class/power_supply/AC/online)

# Inline usage
echo "State: $(cat /file)"

# Nested
result=$(command1 $(command2))
```

## Examples from Scripts

```bash
# Read AC power state
ac_state=$(cat /sys/class/power_supply/AC/online)

# Use in conditional
if [[ $(cat /sys/class/power_supply/AC/online) == "1" ]]; then
    echo "On AC power"
fi
```

## Related

- [[05-Control-Flow]] - Previous: Control Flow
- [[07-Error-Handling]] - Next: Error Handling
