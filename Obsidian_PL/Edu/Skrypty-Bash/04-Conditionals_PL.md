# 04-Conditionals

Warunki kontrolują przepływ skryptu na podstawie warunków.

## Nawiasy testowe [[ ]]

```bash
# Testy plików
[[ -f /sciezka/do/pliku ]]      # Plik istnieje
[[ -d /sciezka/do/katalogu ]]    # Katalog istnieje

# Testy ciągów znaków
[[ "$zmienna" == "wartosc" ]]    # Ciąg równy
[[ "$zmienna" != "wartosc" ]]    # Ciąg nierówny
[[ -z "$zmienna" ]]              # Pusty ciąg
[[ -n "$zmienna" ]]              # Niepusty ciąg

# Testy numeryczne
[[ $num -eq 5 ]]                 # Równe
[[ $num -gt 5 ]]                 # Większe niż
[[ $num -lt 5 ]]                 # Mniejsze niż
```

## Składnia if/else

```bash
if warunek; then
    polecenia
elif inny_warunek; then
    polecenia
else
    polecenia
fi
```

## Przykłady ze skryptów

```bash
# Sprawdzenie istnienia pliku
if [[ -f /proc/acpi/button/lid/LID/state ]]; then
    stan_pokrywy=$(cat /proc/acpi/button/lid/LID/state)
else
    stan_pokrywy="nieznany"
fi

# Połączone z AND
if [[ "$stan_pokrywy" == "closed" ]] && [[ "$stan_ac" == "1" ]]; then
    enable_dock_mode
fi

# Zagnieżdżone warunki
if [[ -f /proc/acpi/button/lid/LID/state ]]; then
    if grep -q "open" /proc/acpi/button/lid/LID/state 2>/dev/null; then
        stan_pokrywy="open"
    else
        stan_pokrywy="closed"
    fi
fi
```

## Powiązane

- [[03-Variables_PL]] - Poprzednie: Zmienne
- [[05-Control-Flow_PL]] - Następne: Sterowanie przepływem
