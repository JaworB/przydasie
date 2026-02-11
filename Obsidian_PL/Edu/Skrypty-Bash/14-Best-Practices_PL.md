# 14-Best-Practices

Wytyczne dotyczące pisania solidnych skryptów daemon.

## 1. Nieskończona pętla z sleep

```bash
while true; do
    sprawdz_warunek
    sleep 2  # Zapobiega wirowaniu CPU
done
```

## 2. Śledź poprzedni stan

```bash
local poprzedni_stan="nieznany"
```

## 3. Używaj zmiennych lokalnych

```bash
local bieżąca_wartość
```

## 4. Pomijaj niepotrzebne wyjście

```bash
polecenie 2>/dev/null
```

## 5. Obsługuj przypadki brzegowe

```bash
if [[ -f /sciezka/do/pliku ]]; then
    # Obsłuż plik
else
    # Obsłuż brakujący plik
fi
```

## 6. Sprawdzaj zależności

```bash
if polecenie -v wymagane_polecenie >/dev/null 2>&1; then
    echo "Znaleziono"
fi
```

## 7. Używaj opisowych nazw

```bash
# Dobrze
enable_dock_mode()
lid_handler_daemon()

# Źle
func1()
cos_rób()
```

## 8. Komentuj złożoną logikę

```bash
# Sprawdź czy pokrywa jest otwarta czy zamknięta
# grep -q zwraca 0 jeśli znaleziono, 1 jeśli nie
```

## Powiązane

- [[13-Event-Detection-Pattern_PL]] - Poprzednie: Wykrywanie zdarzeń
- [[15-Quick-Reference_PL]] - Następne: Szybka referencja
