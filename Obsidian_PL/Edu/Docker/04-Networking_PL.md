# Sieci

Mapowanie portów i zarządzanie sieciami Docker.

## Mapowanie portów

```bash
# Pojedynczy port
docker run -p 8080:8000 moja-aplikacja

# Wiele portów
docker run -p 8080:8000 -p 8443:443 moja-aplikacja

# Określony host
docker run -p 127.0.0.1:8080:8000 moja-aplikacja
```

## Sieci Docker

```bash
# Lista sieci
docker network ls

# Utwórz sieć
docker network create moja-siec

# Szczegóły sieci
docker network inspect moja-siec

# Podłącz kontener do sieci
docker network connect moja-siec moj-kontener

# Odłącz kontener
docker network disconnect moja-siec moj-kontener
```

## Typy sieci

| Typ | Opis |
|-----|------|
| `bridge` | Domyślna sieć dla pojedynczego hosta |
| `host` | Brak izolacji sieciowej |
| `none` | Brak sieci |
| `overlay` | Wielohostowa sieć rozproszona |

## docker-compose.yml

```yaml
version: '3.8'
services:
  aplikacja:
    build: .
    ports:
      - "8080:8000"
    networks:
      - moja-siec
    environment:
      - DB_HOST=db

  db:
    image: postgres:15
    networks:
      - moja-siec
    volumes:
      - db-data:/var/lib/postgresql/data

networks:
  moja-siec:
    driver: bridge

volumes:
  db-data:
```

## Powiązane

- [[03-Containers_PL]] - Poprzednie: Kontenery
- [[05-Volumes_PL]] - Następne: Wolumeny
- [[06-Docker-Compose_PL]] - Docker Compose

## Następne kroki

Przejdź do [[05-Volumes_PL]] aby dowiedzieć się o persystencji danych.
