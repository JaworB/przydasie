# Konfiguracja Hyprland

Twoja konfiguracja menedżera okien Hyprland, zbudowana na frameworku konfiguracyjnym [Omarchy](https://github.com/OldJobobo/omarchy) z niestandardowymi nadpisami.

## Architektura

Hyprland używa warstwowego podejścia do konfiguracji:

```
~/.config/hypr/hyprland.conf
    └── Źródła w kolejności:
        ├── ~/.local/share/omarchy/default/hypr/*      (domyślne Omarchy)
        ├── ~/.config/omarchy/current/theme/hyprland.conf (ustawienia motywu)
        ├── ~/.config/hypr/*.conf (twoje nadpisy)
        └── Osobiste dostosowania na EOF
```

### Pliki konfiguracyjne

| Plik | Przeznaczenie |
|------|--------------|
| `hyprland.conf` | Główny punkt wejścia konfiguracji |
| `bindings.conf` | Skróty uruchamiania aplikacji |
| `monitors.conf` | Konfiguracja wyświetlaczy i monitorów |
| `input.conf` | Ustawienia klawiatury i touchpada |
| `windows.conf` | Mapowanie obszarów roboczych do monitorów |
| `autostart.conf` | Programy do uruchomienia przy logowaniu |
| `hypridle.conf` | Zachowanie bezczynności i auto-lock |
| `hyprlock.conf` | Konfiguracja ekranu blokady |
| `looknfeel.conf` | Nadpisy wyglądu wizualnego |

## Kluczowe zasoby

- [Wiki Hyprland](https://wiki.hyprland.org/Configuring/)
- [Dokumentacja Omarchy](https://github.com/OldJobobo/omarchy)
- [Hyprland GitHub](https://github.com/hyprwm/Hyprland)

## Powiązana dokumentacja

- [[../Arch-po-instalacji/01-DisplayLink-Setup_PL]] - Przegląd konfiguracji DisplayLink
- [[../Arch-po-instalacji/02-DisplayLink-Dock-Setup_PL]] - Instalacja sterownika

## Sekcje

### Konfiguracja
- [[01-Omarchy-Defaults_PL]] - Referencja domyślnej konfiguracji Omarchy
- [[02-Custom-Keybindings_PL]] - Osobiste skróty aplikacji
- [[03-Tiling-Window-Management_PL]] - Nawigacja oknami i kontrola obszarów roboczych
- [[04-Utilities-System_PL]] - Narzędzia systemowe

### Sprzęt
- [[05-Display-Setup_PL]] - Konfiguracja monitora i DisplayLink
- [[06-Input-Devices_PL]] - Ustawienia klawiatury i touchpada
- [[07-Workspaces_PL]] - Mapowanie obszarów roboczych do monitorów

### Automatyzacja
- [[08-Idle-Lock_PL]] - Auto-lock i zarządzanie energią
- [[09-Custom-Scripts/index_PL]] - Niestandardowe skrypty powłoki dla Hyprland
  - [[09-Custom-Scripts/01-lid-handler-daemon_PL]] - Daemon monitorowania stanu pokrywy
  - [[09-Custom-Scripts/02-toggle-dock-mode_PL]] - Ręczne przełączanie trybu dock
  - [[09-Custom-Scripts/03-fix-cursor-vertical_PL]] - Rekalingulacja kursora
  - [[09-Custom-Scripts/04-toggle-audio-output_PL]] - Przełączanie wyjścia audio
