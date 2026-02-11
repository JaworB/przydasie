# 10-Hyprland-Integration

Sterowanie menedżerem okien Hyprland.

## Polecenia hyprctl

```bash
hyprctl keyword monitor "nazwa, rozdzielczość@Hz, pozycja, skala"
hyprctl keyword cursor x y
hyprctl monitors
```

## Przykłady ze skryptów

```bash
# Wyłącz monitor
hyprctl keyword monitor "eDP-1, disable"

# Konfiguruj zewnętrzny monitor
hyprctl keyword monitor "DVI-I-1, 3440x1440@50.00, 0x0, 1"

# Konfiguruj monitor laptopa
hyprctl keyword monitor "eDP-1, preferred, 0x1440, 2"

# Rekalinguj kursor
hyprctl keyword cursor 1 1
hyprctl keyword cursor 0 0

# Wyświetl monitory
hyprctl monitors
```

## Rozbicie polecenia

```bash
hyprctl keyword monitor "DVI-I-1, 3440x1440@50.00, 0x0, 1"
#              |       |       |        |        |  |
#              |       |       |        |        |  +-- skala: 1
#              |       |       |        |        +----- y: 0
#              |       |       |        +-------------- x: 0
#              |       |       +----------------------- odświeżanie
#              |       +------------------------------ nazwa
#              +------------------------------------- hyprland
```

## Powiązane

- [[09-Logical-Operators_PL]] - Poprzednie: Operatory logiczne
- [[11-Sleep-and-Timing_PL]] - Następne: Sen i timery
