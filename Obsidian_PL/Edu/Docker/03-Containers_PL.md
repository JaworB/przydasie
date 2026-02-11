# Kontenery

Uruchamianie i zarządzanie kontenerami Docker.

## Uruchamianie kontenerów

```bash
# Uruchom kontener
docker run moja-aplikacja

# Uruchom w tle (detached)
docker run -d moja-aplikacja

# Uruchom z nazwą
docker run --name moj-kontener -d moja-aplikacja

# Uruchom interaktywnie
docker run -it ubuntu bash

# Mapowanie portów
docker run -p 8080:8000 moja-aplikacja

# Zmienne środowiskowe
docker run -e DB_HOST=localhost moja-aplikacja
```

## Zarządzanie kontenerami

```bash
# Lista kontenerów (działających)
docker ps

# Lista wszystkich kontenerów
docker ps -a

# Status kontenera
docker stats moj-kontener

# Logs
docker logs moj-kontener
docker logs -f moj-kontener  # Follow

# Inspect
docker inspect moj-kontener

# Top
docker top moj-kontener
```

## Cykl życia kontenera

```bash
# Zatrzymaj
docker stop moj-kontener

# Uruchom ponownie
docker restart moj-kontener

# Wymuś zatrzymanie
docker kill moj-kontener

# Usuń
docker rm moj-kontener
docker rm -f moj-kontener  # Wymuś

# Wyczyść
docker system prune
```

## Exec w kontenerze

```bash
# Wykonaj polecenie
docker exec moj-kontener ls /app

# Tryb interaktywny
docker exec -it moj-kontener bash
```

## Kopiowanie plików

```bash
# Z kontenera do hosta
docker cp moj-kontener:/app/config.txt .

# Z hosta do kontenera
docker cp config.txt moj-kontener:/app/
```

## Powiązane

- [[02-Images_PL]] - Poprzednie: Obrazy
- [[04-Networking_PL]] - Następne: Sieci
- [[10-Lazydocker_PL]] - UI dla Docker

## Następne kroki

Przejdź do [[04-Networking_PL]] aby dowiedzieć się o sieciach.
