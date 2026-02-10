# 01-Shebang

The shebang is the first line of a script that tells the system which interpreter should execute the script.

## Syntax

```bash
#!/bin/bash
```

## Common Shebangs

```bash
#!/bin/bash      # Bash shell
#!/bin/sh        # POSIX shell
#!/usr/bin/env bash  # Find bash in PATH
#!/usr/bin/python3   # Python interpreter
#!/bin/bash -login   # Login shell
```

## Examples from Scripts

All DisplayLink scripts use:

```bash
#!/bin/bash

# lid-handler-daemon.sh - Line 1
#!/bin/bash

# toggle-dock-mode.sh - Line 1
#!/bin/bash

# fix-cursor-vertical.sh - Line 1
#!/bin/bash
```

## Why Use #!/bin/bash

- Specifies bash as the interpreter
- Enables bash-specific features (`[[ ]]`, `$()`, functions, etc.)
- Required for script to run correctly

## Related

- [[02-Functions]] - Next: Functions
