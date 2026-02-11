# Wprowadzenie

Docker to platforma do budowania i uruchamiania kontenerów.

## Czym jest Docker?

- Izolacja aplikacji w kontenerach
- Lekkie w porównaniu do maszyn wirtualnych
- Spójne środowisko (dev/prod)
- Łatwe skalowanie

## Kontenery vs Maszyny wirtualne

| Aspekt | Kontenery | Maszyny wirtualne |
|--------|-----------|------------------|
| Izolacja | Przestrzeń procesów | Pełny OS |
| Rozmiar | MB | GB |
| Czas uruchomienia | Sekundy | Minuty |
| Współdzielenie OS | Tak | Nie |

## Architektura Docker

```
+-------------------------------------------+
|          Aplikacje użytkownika            |
+-------------------------------------------+
|          Docker Engine (daemon)           |
+-------------------------------------------+
|          System operacyjny (host)         |
+-------------------------------------------+
|          Hardware                         |
+-------------------------------------------+
```

## Instalacja

```bash
# Linux (Ubuntu)
sudo apt update
sudo apt install docker.io

# Dodaj użytkownika do grupy docker
sudo usermod -aG docker $USER

# macOS/Windows
# Pobierz Docker Desktop
```

## Hello World

```bash
# Uruchom kontener
docker run hello-world

# Uruchom interaktywnie
docker run -it ubuntu bash
```

## Powiązane

- [[02-Images_PL]] - Następne: Obrazy Docker
- [[03-Containers_PL]] - Kontenery

## Następne kroki

Przejdź do [[02-Images_PL]] aby dowiedzieć się o budowaniu obrazów.
