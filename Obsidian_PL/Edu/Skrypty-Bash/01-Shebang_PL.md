# 01-Shebang

Shebang to pierwsza linia skryptu, która informuje system, który interpreter powinien wykonać skrypt.

## Składnia

```bash
#!/bin/bash
```

## Popularne Shebangi

```bash
#!/bin/bash      # Powłoka Bash
#!/bin/sh        # Powłoka POSIX
#!/usr/bin/env bash  # Znajdź bash w PATH
#!/usr/bin/python3   # Interpreter Python
#!/bin/bash -login   # Powłoka logowania
```

## Przykłady ze skryptów

Wszystkie skrypty DisplayLink używają:

```bash
#!/bin/bash

# lid-handler-daemon.sh - Linia 1
#!/bin/bash

# toggle-dock-mode.sh - Linia 1
#!/bin/bash

# fix-cursor-vertical.sh - Linia 1
#!/bin/bash
```

## Dlaczego używać #!/bin/bash

- Określa bash jako interpreter
- Włącza funkcje specyficzne dla bash (`[[ ]]`, `$()`, funkcje itp.)
- Wymagane do poprawnego działania skryptu

## Powiązane

- [[02-Functions_PL]] - Następne: Funkcje
