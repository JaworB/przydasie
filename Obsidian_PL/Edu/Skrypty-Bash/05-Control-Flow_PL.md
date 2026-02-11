# 05-Control-Flow

Instrukcje sterowania przepływem zarządzają kolejnością wykonywania skryptu.

## Pętla while (wzorzec daemon)

```bash
while true; do
    # Polecenia
    sleep 2
done
```

Tworzy nieskończoną pętlę dla daemonów.

## Pętla for

```bash
for i in 1 2 3 4 5; do
    echo "Iteracja $i"
done

# Wzorzec glob
for plik in *.txt; do
    echo "Przetwarzanie $pliku"
done
```

## Pętla until

```bash
until [ warunek ]; do
    # Powtarzaj aż będzie true
done
```

## Przykłady ze skryptów

```bash
# Pętla daemon
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

## Powiązane

- [[04-Conditionals_PL]] - Poprzednie: Warunki
- [[06-Command-Substitution_PL]] - Następne: Podstawianie poleceń
