# Wolumeny

Persystencja danych w Docker.

## Typy danych w kontenerach

```
┌─────────────────────────────────────┐
│          Warstwa tylko do odczytu    │
│         (Obraz kontenera)            │
├─────────────────────────────────────┤
│          Warstwa zapisywalna          │
│        (Kontener - nietrwałe)        │
├─────────────────────────────────────┤
│     Wolumeny (trwałe dane)           │
└─────────────────────────────────────┘
```

## Tworzenie wolumenów

```bash
# Utwórz wolumen
docker volume create moj-wolumen

# Lista wolumenów
docker volume ls

# Szczegóły wolumenu
docker volume inspect moj-wolumen

# Usuń wolumen
docker volume rm moj-wolumen
```

## Montowanie wolumenów

```bash
# Montowanie wolumenu
docker run -v moj-wolumen:/app/data moja-aplikacja

# Montowanie katalogu hosta
docker run -v $(pwd)/data:/app/data moja-aplikacja

# Montowanie pojedynczego pliku
docker run -v $(pwd)/config.json:/app/config.json moja-aplikacja
```

## docker-compose.yml

```yaml
volumes:
  db-data:
  app-data:

services:
  db:
    image: postgres:15
    volumes:
      - db-data:/var/lib/postgresql/data

  aplikacja:
    build: .
    volumes:
      - ./data:/app/data
      - app-data:/app/persistent
```

## Kopie zapasowe

```bash
# Backup wolumenu
docker run --rm -v moj-wolumen:/data -v $(pwd):/backup ubuntu tar czf /backup/backup.tar.gz -C /data .

# Restore wolumenu
docker run --rm -v moj-wolumen:/data -v $(pwd):/backup ubuntu sh -c "cd /data && tar xzf /backup/backup.tar.gz --strip-components=1"
```

## Powiązane

- [[04-Networking_PL]] - Poprzednie: Sieci
- [[06-Docker-Compose_PL]] - Następne: Docker Compose
- [[05-Volumes]] w [[../Skrypty-Bash/index_PL]] - Wolumeny w Bash

## Następne kroki

Przejdź do [[06-Docker-Compose_PL]] aby dowiedzieć się o aplikacjach wielokontenerowych.
