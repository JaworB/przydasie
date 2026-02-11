# 03-Variables

Zmienne przechowują dane do późniejszego użycia.

## Zmienne globalne

```bash
current_dock_mode=false
```

- Definiowane poza funkcjami
- Dostępne w całym skrypcie
- Używane do śledzenia stanu

## Zmienne lokalne

```bash
local nazwa_zmiennej="wartosc"
```

- Zakres ograniczony do funkcji
- Zapobiega zanieczyszczeniu przestrzeni nazw
- Zalecane dla wartości tymczasowych

## Przypisanie

```bash
# Proste przypisanie (bez spacji)
zmienna="wartosc"

# Podstawienie polecenia
wynik=$(polecenie)

# Rozszerzenie parametrów
wartosc="${zmienna:-domyslna}"
```

## Przykłady ze skryptów

```bash
# Globalny stan dla wzorca toggle
current_dock_mode=false

# Zmienne lokalne w daemonie
lid_handler_daemon() {
    local poprzedni_stan_pokrywy="nieznany"
    local poprzedni_stan_ac="nieznany"
    local stan_pokrywy
    local stan_ac

    stan_pokrywy="open"
    stan_ac=$(cat /sys/class/power_supply/AC/online)
}
```

## Powiązane

- [[02-Functions_PL]] - Poprzednie: Funkcje
- [[04-Conditionals_PL]] - Następne: Warunki
