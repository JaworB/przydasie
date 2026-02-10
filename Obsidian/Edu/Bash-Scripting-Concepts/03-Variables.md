# 03-Variables

Variables store data for later use.

## Global Variables

```bash
current_dock_mode=false
```

- Defined outside functions
- Accessible throughout entire script
- Used for persistent State tracking

## Local Variables

```bash
local var_name="value"
```

- Scope limited to containing function
- Prevents namespace pollution
- Recommended for temporary values

## Assignment

```bash
# Simple assignment (no spaces)
var="value"

# Command substitution
result=$(command)

# Parameter expansion
value="${var:-default}"
```

## Examples from Scripts

```bash
# Global state for toggle pattern
current_dock_mode=false

# Local variables in daemon
lid_handler_daemon() {
    local previous_lid_state="unknown"
    local previous_ac_state="unknown"
    local lid_state
    local ac_state

    lid_state="open"
    ac_state=$(cat /sys/class/power_supply/AC/online)
}
```

## Related

- [[02-Functions]] - Previous: Functions
- [[04-Conditionals]] - Next: Conditionals
