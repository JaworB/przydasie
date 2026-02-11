# 11-Sleep-and-Timing

Dodawanie opóźnień do skryptów.

## Polecenie sleep

```bash
sleep 2          # 2 sekundy
sleep 0.5        # 500 milisekund
sleep 1m         # 1 minuta
sleep 1h         # 1 godzina
```

## Przykłady ze skryptów

```bash
# Interwał odpytywania daemon
while true; do
    sprawdz_stan
    sleep 2  # Czekaj 2 sekundy
done
```

## Powiązane

- [[10-Hyprland-Integration_PL]] - Poprzednie: Integracja z Hyprland
- [[12-Toggle-Pattern_PL]] - Następne: Wzorzec toggle
