# 07-Error-Handling

Obsługuj błędy i pomijaj niechciane wyjście.

## Przekierowanie stderr

```bash
polecenie 2>/dev/null
```

- `2` = deskryptor pliku stderr
- `/dev/null` = odrzuć wyjście

## Kody wyjścia

```bash
polecenie
echo $?     # Wyświetl kod wyjścia
```

- `0` = Sukces
- `1` = Ogólny błąd
- `2` = Błędne użycie polecenia powłoki
- `127` = Polecenie nie znalezione

## Przykłady ze skryptów

```bash
# Pomiń błędy jeśli plik brakuje
grep -q "open" /proc/acpi/button/lid/LID/state 2>/dev/null

# Sprawdź plik przed odczytem
if [[ -f /proc/acpi/button/lid/LID/state ]]; then
    cat /proc/acpi/button/lid/LID/state
fi
```

## Powiązane

- [[06-Command-Substitution_PL]] - Poprzednie: Podstawianie poleceń
- [[08-Process-Management_PL]] - Następne: Zarządzanie procesami
