# Podman

Bezdemonowy konteneryzator, alternatywa dla Docker.

## Czym jest Podman?

- Bezdemone - nie wymaga root
- Zgodność z Docker CLI
- Obsługuje kontenery rootless
- Kompatybilny z docker-compose

## Instalacja

```bash
# Linux (Ubuntu/Debian)
sudo apt install podman

# macOS/Windows
# Pobierz Podman Desktop
# https://podman.io/get-started
```

## Podstawowe polecenia

```bash
# Odpowiedniki docker
podman run -d --name moj-kontener moja-aplikacja
podman ps
podman stop moj-kontener
podman rm moj-kontener
podman images

# Build
podman build -t moja-aplikacja .

# Push do registry
podman push moja-aplikacja
```

## Rootless kontenery

```bash
# Uruchom jako zwykły użytkownik
podman run --rm -it alpine /bin/sh

# Skonfiguruj kontener dla rootless
# ~/.config/containers/containers.conf
```

## Docker compatibility

```bash
# Alias docker -> podman
alias docker=podman

# Użyj docker-compose
docker-compose up -d
```

## Podman Desktop

- Graficzny interfejs
- Łatwe zarządzanie wolumenami
- Wbudowany Kubernetes
- Integracja z terminalem

## Konwersja z Docker

```bash
# Podman używa tych samych obrazów
podman pull docker.io/library/python:3.11

# Pliki Dockerfile działają tak samo
podman build -t moja-aplikacja .
```

## Powiązane

- [[06-Docker-Compose_PL]] - Poprzednie: Docker Compose
- [[08-Containerization_PL]] - Następne: Najlepsze praktyki
- [[07-Podman]] w [[../Ansible-Concepts/index_PL]] - Provisioning z Podman

## Następne kroki

Przejdź do [[08-Containerization_PL]] aby dowiedzieć się o najlepszych praktykach i bezpieczeństwie.
