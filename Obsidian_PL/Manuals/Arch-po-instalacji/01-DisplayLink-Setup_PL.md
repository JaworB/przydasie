# Konfiguracja DisplayLink

Lokalna referencja dla konfiguracji stacji dokującej DisplayLink.

## Przewodniki

- [[02-DisplayLink-Dock-Setup_PL]] - Instalacja sterownika i konfiguracja monitora
- [[../Konfiguracja-Hyprland/Wlasne-skrypty/01-lid-handler-daemon_PL]] - Zautomatyzowane zachowanie zamykania pokrywy

## Skrypty

Znajdują się w `~/.local/bin/`:
- `lid-handler-daemon.sh` - Daemon w tle do monitorowania stanu pokrywy
- `toggle-dock-mode.sh` - Ręczne przełączanie trybu dock (SUPER+M)
- `fix-cursor-vertical.sh` - Rekalingulacja kursora dla pionowego układu
- `toggle-audio-output.sh` - Przełączanie między AirPods a głośnikami (SUPER+SHIFT+A)

## Szybkie polecenia

```bash
# Przełącz tryb dock
~/.local/bin/toggle-dock-mode.sh

# Sprawdź status monitorów
hyprctl monitors

# Restart obsługi pokrywy
killall lid-handler-daemon.sh && ~/.local/bin/lid-handler-daemon.sh

# Przełącz wyjście audio
~/.local/bin/toggle-audio-output.sh
```

## Powiązane

- [[../Konfiguracja-Hyprland/index_PL]] - Konfiguracja Hyprland
- [[02-DisplayLink-Dock-Setup_PL]] - Szczegółowa konfiguracja
- [[../Konfiguracja-Hyprland/Wlasne-skrypty/index_PL]] - Własne skrypty
