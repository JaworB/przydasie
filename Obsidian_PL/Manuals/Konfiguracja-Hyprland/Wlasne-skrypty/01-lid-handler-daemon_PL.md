# Automatyzacja przełączania pokrywy

Daemon w tle, który monitoruje stan pokrywy i zasilanie AC, aby automatycznie przełączać tryby wyświetlania lub suspendować.

## Zachowanie

| Stan pokrywy | Źródło zasilania | Akcja |
|-------------|------------------|------|
| Zamknięta | Zasilanie sieciowe | Włącz tryb dock (eDP-1 wyłączony) |
| Zamknięta | Bateria | Suspenduj system |
| Otwarta | Jakiekolwiek | Normalny tryb (oba monitory aktywne) |

## Lokalizacja

```
~/.local/bin/lid-handler-daemon.sh
```

## Start/Stop

```bash
# Uruchom daemon (przy logowaniu przez autostart.conf)
~/.local/bin/lid-handler-daemon.sh

# Restart daemon
killall lid-handler-daemon.sh && ~/.local/bin/lid-handler-daemon.sh

# Sprawdź czy działa
pgrep -f lid-handler-daemon.sh
```

## Konfiguracja monitora

### Normalny tryb (Pionowy stos)
```
+------------------------+
|    DVI-I-1 (Góra)     | 3440x1440@50Hz na 0x0
+------------------------+
|      eDP-1 (Dół)      | 3840x2160@60Hz na 0x1440, skala 2
+------------------------+
```

### Tryb dock (Pokrywa zamknięta + AC)
- **DVI-I-1**: 3440x1440@50Hz, pozycja 0x0
- **eDP-1**: Wyłączony

Uwaga: Sterownik DisplayLink ogranicza częstotliwość odświeżania do maksimum 50Hz.

## Polecenia ręczne

```bash
# Przełącz tryb dock
~/.local/bin/toggle-dock-mode.sh

# Napraw kursor dla pionowego stosu
~/.local/bin/fix-cursor-vertical.sh

# Przywróć dwa monitory (pionowy stos)
hyprctl keyword monitor "DVI-I-1, 3440x1440@50.00, 0x0, 1"
hyprctl keyword monitor "eDP-1, preferred, 0x1440, 2"
```

## Testowanie

```bash
# Testuj wykrywanie pokrywy
cat /proc/acpi/button/lid/LID/state

# Testuj wykrywanie AC
cat /sys/class/power_supply/AC/online

# Sprawdź czy daemon działa
ps aux | grep lid-handler

# Zweryfikuj pozycje monitorów
hyprctl monitors | grep -E "at.*x|@.*Hz"
```

## Źródło

```bash
#!/bin/bash

lid_handler_daemon() {
    local poprzedni_stan_pokrywy="nieznany"
    local poprzedni_stan_ac="nieznany"

    while true; do
        local stan_pokrywy
        local stan_ac

        if [[ -f /proc/acpi/button/lid/LID/state ]]; then
            if grep -q "open" /proc/acpi/button/lid/LID/state 2>/dev/null; then
                stan_pokrywy="open"
            else
                stan_pokrywy="closed"
            fi
        else
            stan_pokrywy="nieznany"
        fi

        if [[ -f /sys/class/power_supply/AC/online ]]; then
            stan_ac=$(cat /sys/class/power_supply/AC/online)
        else
            stan_ac="nieznany"
        fi

        if [[ "$stan_pokrywy" != "$poprzedni_stan_pokrywy" ]] || [[ "$stan_ac" != "$poprzedni_stan_ac" ]]; then
            if [[ "$stan_pokrywy" == "closed" ]] && [[ "$stan_ac" == "1" ]]; then
                enable_dock_mode
            elif [[ "$stan_pokrywy" == "closed" ]] && [[ "$stan_ac" != "1" ]]; then
                systemctl suspend
            else
                enable_normal_mode
            fi
            poprzedni_stan_pokrywy="$stan_pokrywy"
            poprzedni_stan_ac="$stan_ac"
        fi

        sleep 2
    done
}

enable_dock_mode() {
    hyprctl keyword monitor "eDP-1, disable"
    hyprctl keyword monitor "DVI-I-1, 3440x1440@50.00, 0x0, 1"
}

enable_normal_mode() {
    hyprctl keyword monitor "DVI-I-1, 3440x1440@50.00, 0x0, 1"
    hyprctl keyword monitor "eDP-1, preferred, 0x1440, 2"
}

lid_handler_daemon
```

## Powiązane

- [[02-toggle-dock-mode_PL]] - Ręczne przełączanie dock
- [[03-fix-cursor-vertical_PL]] - Rekalingulacja kursora
- [[04-toggle-audio-output_PL]] - Przełączanie wyjścia audio
- [[index_PL]] - Indeks skryptów
