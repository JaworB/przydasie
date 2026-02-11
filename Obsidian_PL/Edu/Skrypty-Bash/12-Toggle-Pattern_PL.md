# 12-Toggle-Pattern

Maszyna stanów, która przełącza między dwoma stanami.

## Wzorzec

```bash
current_state=false

toggle() {
    if $current_state; then
        # Akcja A
        current_state=false
    else
        # Akcja B
        current_state=true
    fi
}
```

## Przykłady ze skryptów

```bash
current_dock_mode=false

toggle_dock_mode() {
    if $current_dock_mode; then
        # Przywróć dwa monitory
        hyprctl keyword monitor "DVI-I-1, 3440x1440@50.00, 0x0, 1"
        hyprctl keyword monitor "eDP-1, preferred, 0x1440, 2"
        current_dock_mode=false
        echo "Przełączono na normalny tryb"
    else
        # Włącz tylko dock
        hyprctl keyword monitor "eDP-1, disable"
        hyprctl keyword monitor "DVI-I-1, 3440x1440@50.00, 0x0, 1"
        current_dock_mode=true
        echo "Przełączono na tryb dock"
    fi
}

toggle_dock_mode
```

## Powiązane

- [[11-Sleep-and-Timing_PL]] - Poprzednie: Sen i timery
- [[13-Event-Detection-Pattern_PL]] - Następne: Wykrywanie zdarzeń
