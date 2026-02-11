# 06-Command-Substitution

Podstawianie poleceń przechwytuje wyjście polecenia do użycia w zmiennych.

## Składnia

```bash
$(polecenie)    # Nowoczesna
`polecenie`      # Starsza
```

## Użycie

```bash
# Przechwyć wyjście
stan_ac=$(cat /sys/class/power_supply/AC/online)

# Użycie w linii
echo "Stan: $(cat /plik)"

# Zagnieżdżone
wynik=$(polecenie1 $(polecenie2))
```

## Przykłady ze skryptów

```bash
# Odczyt stanu zasilania AC
stan_ac=$(cat /sys/class/power_supply/AC/online)

# Użycie w warunku
if [[ $(cat /sys/class/power_supply/AC/online) == "1" ]]; then
    echo "Na zasilaniu AC"
fi
```

## Powiązane

- [[05-Control-Flow_PL]] - Poprzednie: Sterowanie przepływem
- [[07-Error-Handling_PL]] - Następne: Obsługa błędów
