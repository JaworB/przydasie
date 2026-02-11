---
created: 2026-02-08
tags: [hardware, dock, displaylink, multi-monitor]
---

# DisplayLink Dock - Konfiguracja drugiego monitora

## Sprzęt
- **Stacja dokująca**: Lenovo ThinkPad Hybrid USB-C z USB-A Dock
- **Połączenie**: USB-C do laptopa, HDMI/DisplayPort do monitora
- **Monitor**: Xiaomi Mi Monitor (3440x1440@50Hz)

## Problem

Stacje dokujące DisplayLink używają USB do transmisji wideo, nie natywnego DisplayPort. Wymaga to zastrzeżonego sterownika.

## Rozwiązanie

### 1. Zainstaluj sterownik DisplayLink

```bash
# Zainstaluj zależności
sudo pacman -S dkms linux-headers

# Zainstaluj z AUR
yay -S evdi-dkms displaylink
```

### 2. Włącz usługę

```bash
sudo systemctl enable displaylink.service
sudo systemctl start displaylink.service
```

### 3. Zweryfikuj instalację

```bash
systemctl status displaylink.service
hyprctl monitors
```

## Konfiguracja monitora

### Układ monitora (Pionowy stos)
```
+------------------------+
|    DVI-I-1 (Góra)     | 3440x1440@50Hz na 0x0
+------------------------+
|                        |
|      eDP-1 (Dół)      | 3840x2160@60Hz na 0x1440, skala 2
+------------------------+
```

| Ustawienie | Wartość |
|-----------|---------|
| DVI-I-1 Rozdzielczość | 3440x1440 |
| DVI-I-1 Częstotliwość odświeżania | 50Hz |
| DVI-I-1 Pozycja | 0x0 (góra) |
| eDP-1 Pozycja | 0x1440 (pod DVI-I-1) |
| eDP-1 Skala | 2 |

### Ustawianie pozycji monitora

```bash
# Konfiguruj monitory (zdefiniowane w ~/.config/hypr/monitors.conf)
monitor = DVI-I-1, 3440x1440@50.00, 0x0, 1
monitor = eDP-1, preferred, 0x1440, 2
```

Uwaga: Sterownik DisplayLink ogranicza częstotliwość odświeżania do maksimum 50Hz.

### Obok siebie (Alternatywa)

Układ obok siebie jest dostępny, ale rzadziej używany:
```
+------------------------+------------------------+
|    DVI-I-1 (Lewy)      |     eDP-1 (Prawy)      |
|  3440x1440@50Hz na 0x0 | 3840x2160@60Hz na 3440x0
+------------------------+------------------------+
```

Aby włączyć układ obok siebie:
```bash
monitor = DVI-I-1, 3440x1440@50.00, 0x0, 1
monitor = eDP-1, preferred, 3440x0, 2
```

## Polecenia

| Polecenie | Opis |
|-----------|------|
| `hyprctl monitors` | Wyświetl wszystkie podłączone monitory |
| `hyprctl keyword monitor "DVI-I-1, 3440x1440@50.00, 0x0, 1"` | Ustaw pozycję i częstotliwość DVI-I-1 |

## Rozwiązywanie problemów

| Problem | Rozwiązanie |
|---------|-------------|
| Monitor nie wykryty | Sprawdź usługę DisplayLink: `systemctl status displaylink.service` |
| Zła pozycja | Zastosuj: `hyprctl keyword monitor "DVI-I-1, 3440x1440@50.00, 0x0, 1"` |
| Czarny ekran | Restart usługi: `sudo systemctl restart displaylink.service` |
| Niska rozdzielczość | Zweryfikuj EDID: `cat /sys/class/drm/card0-DVI-I-1/edid` |

## Powiązane

- [[../Konfiguracja-Hyprland/Wlasne-skrypty/01-lid-handler-daemon_PL]] - Zautomatyzowane zachowanie zamykania pokrywy
