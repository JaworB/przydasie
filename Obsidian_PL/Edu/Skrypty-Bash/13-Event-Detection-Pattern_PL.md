# 13-Event-Detection-Pattern

Wykrywanie zmian stanu przez porównanie wartości bieżącej z poprzednią.

## Wzorzec

```bash
poprzedni="nieznany"
while true; do
    bieżący=$(pobierz_stan)
    if [[ "$bieżący" != "$poprzedni" ]]; then
        obsłuż_zmianę
        poprzedni="$bieżący"
    fi
    sleep interwał
done
```

## Przykłady ze skryptów

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

        # Wykrywanie zmian stanu
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

## Powiązane

- [[12-Toggle-Pattern_PL]] - Poprzednie: Wzorzec toggle
- [[14-Best-Practices_PL]] - Następne: Najlepsze praktyki
