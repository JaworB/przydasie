# 07-Error-Handling

Handle errors and suppress unwanted output.

## Redirect stderr

```bash
command 2>/dev/null
```

- `2` = stderr file descriptor
- `/dev/null` = discard output

## Exit Codes

```bash
command
echo $?     # Print exit code
```

- `0` = Success
- `1` = General error
- `2` = Misuse of shell command
- `127` = Command not found

## Examples from Scripts

```bash
# Suppress errors if file missing
grep -q "open" /proc/acpi/button/lid/LID/state 2>/dev/null

# Check file before reading
if [[ -f /proc/acpi/button/lid/LID/state ]]; then
    cat /proc/acpi/button/lid/LID/state
fi
```

## Related

- [[06-Command-Substitution]] - Previous: Command Substitution
- [[08-Process-Management]] - Next: Process Management
