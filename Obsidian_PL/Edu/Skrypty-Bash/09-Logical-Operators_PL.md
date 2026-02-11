# 09-Logical-Operators

Łączenie warunków i łańcuchowanie poleceń.

## Operator AND (&&)

```bash
polecenie1 && polecenie2
```

Uruchom polecenie2 TYLKO jeśli polecenie1 się powiedzie.

## Operator OR (||)

```bash
polecenie1 || polecenie2
```

Uruchom polecenie2 TYLKO jeśli polecenie1 się nie powiedzie.

## Przykłady ze skryptów

```bash
# Wzorzec if-then-else
grep -q "open" /proc/acpi/button/lid/LID/state 2>/dev/null && \
    stan_pokrywy="open" || \
    stan_pokrywy="closed"

# Łańcuchowanie poleceń
polecenie1 && polecenie2 && polecenie3

# Odzyskiwanie po błędzie
polecenie1 || polecenie_awaryjne

# Połączone z warunkami
if [[ -f plik ]] && cat plik; then
    echo "Sukces"
fi
```

## Powiązane

- [[08-Process-Management_PL]] - Poprzednie: Zarządzanie procesami
- [[10-Hyprland-Integration_PL]] - Następne: Integracja z Hyprland
