# Lazydocker

Graficzny interfejs dla Docker i Docker Compose.

## Czym jest Lazydocker?

Lazydocker to prosty, oparty na terminalu interfejs dla Docker, napisany w Go.

## Instalacja

```bash
# Linux
curl -SL https://github.com/jesseduffield/lazydocker/releases/latest/download/lazydocker_Linux_x86_64.tar.gz | sudo tar xz -C /usr/local/bin lazydocker

# macOS
brew install lazydocker

# Docker (kontener)
docker run --rm -it -v /var/run/docker.sock:/var/run/docker.sock \
  -v $HOME/.config/jesseduffield/lazydocker:/root/.config/jesseduffield/lazydocker \
  lazyteam/lazydocker
```

## Interfejs

```
┌──────────────────────────────────────────────────────┐
│ Lazydocker                            v0.26.0         │
├──────────────────────────────────────────────────────┤
│ Services  Containers  Images  Volumes  Networks Config │
│                                                            │
│ Containers                    Uptime    CPU    Memory          │
│ ─────────────────────────────────────────────────────── │
│ my-app                     2d 5h    0.02%   256MB           │
│ postgres                   2d 5h    0.01%   128MB           │
│ redis                      2d 5h    0.00%    64MB           │
│                                                            │
│ ─────────────────────────────────────────────────────── │
│ Logs                        Uptime    CPU    Memory          │
│ ─────────────────────────────────────────────────────── │
│ 2024-01-15 10:30:00 Application started...               │
│                                                            │
│ ─────────────────────────────────────────────────────── │
│ m: menu | r: restart | s: stop | c: compose | q: quit   │
└──────────────────────────────────────────────────────┘
```

## Nawigacja

| Klawisz | Akcja |
|---------|-------|
| `Tab` | Przełącz panele |
| `↑/↓` | Nawiguj |
| `Enter` | Szczegóły |
| `r` | Restart |
| `s` | Stop |
| `c` | Docker Compose |
| `m` | Menu |
| `q` | Wyjście |

## Główne funkcje

- **Kontenery** - Restart, stop, logi, exec
- **Obrazy** - Pull, remove, history
- **Wolumeny** - Inspect, remove
- **Docker Compose** - Up, down, logs
- **Statystyki** - CPU, pamięć, sieć

## Konfiguracja

```yaml
# ~/.config/jesseduffield/lazydocker/config.yml
gui:
  theme:
    activeBorderColor:
      - green
      - bold
  scrollHeight: 2

customCommands:
  - name: "Cleanup Unused"
    command: "docker image prune -f && docker container prune -f"
    context: "global"
```

## Powiązane

- [[09-Cheatsheet_PL]] - Poprzednie: Ściągawka
- [[03-Containers_PL]] - Kontenery
- [[06-Docker-Compose_PL]] - Docker Compose

## Następne kroki

Wróć do [[index_PL]] do pełnego przewodnika Docker.
