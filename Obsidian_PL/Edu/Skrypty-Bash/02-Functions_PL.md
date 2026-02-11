# 02-Functions

Funkcje grupują powiązane polecenia w bloki wielokrotnego użytku.

## Definicja

```bash
nazwa_funkcji() {
    # Polecenia
}
```

## Kluczowe koncepcje

- **Wielokrotne użytku**: Napisz raz, wywołuj wielokrotnie
- **Organizacja**: Grupuj powiązane polecenia logicznie
- **Zakres lokalny**: Zmienne mogą być ograniczone do funkcji

## Przykłady ze skryptów

### Funkcja Daemon

```bash
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
            else
                enable_normal_mode
            fi
            poprzedni_stan_pokrywy="$stan_pokrywy"
            poprzedni_stan_ac="$stan_ac"
        fi

        sleep 2
    done
}
```

### Funkcje konfiguracji trybu

```bash
enable_dock_mode() {
    hyprctl keyword monitor "eDP-1, disable"
    hyprctl keyword monitor "DVI-I-1, 3440x1440@50.00, 0x0, 1"
}

enable_normal_mode() {
    hyprctl keyword monitor "DVI-I-1, 3440x1440@50.00, 0x0, 1"
    hyprctl keyword monitor "eDP-1, preferred, 0x1440, 2"
}

fix_cursor_vertical() {
    hyprctl keyword monitor "DVI-I-1, 3440x1440@50.00, 0x0, 1"
    hyprctl keyword monitor "eDP-1, preferred, 0x1440, 2"
    hyprctl keyword cursor 1 1
    hyprctl keyword cursor 0 0
}
```

## Powiązane

- [[01-Shebang_PL]] - Poprzednie: Shebang
- [[03-Variables_PL]] - Następne: Zmienne
