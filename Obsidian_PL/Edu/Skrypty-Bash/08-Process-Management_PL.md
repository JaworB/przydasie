# 08-Process-Management

Zarządzanie procesami w tle.

## Procesy w tle

```bash
polecenie &
```

Uruchom polecenie w tle.

## Zabijanie procesów

```bash
killall nazwa_procesu    # Zabij po nazwie
pkill -f "wzorzec"       # Zabij według wzorca
kill PID                  # Zabij po PID
kill -9 PID               # Wymuś zabicie
```

## Przykłady ze skryptów

```bash
# Uruchom daemon w tle
~/.local/bin/lid-handler-daemon.sh &

# Restart daemon
killall lid-handler-daemon.sh && ~/.local/bin/lid-handler-daemon.sh &

# Sprawdź status
ps aux | grep lid-handler-daemon
```

## Powiązane

- [[07-Error-Handling_PL]] - Poprzednie: Obsługa błędów
- [[09-Logical-Operators_PL]] - Następne: Operatory logiczne
