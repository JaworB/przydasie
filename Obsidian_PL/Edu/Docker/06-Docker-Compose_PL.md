# Docker Compose

Zarządzanie aplikacjami wielokontenerowymi.

## docker-compose.yml

```yaml
version: '3.8'

services:
  web:
    build: .
    ports:
      - "5000:5000"
    environment:
      - REDIS_URL=redis://redis:6379
    depends_on:
      - redis
    networks:
      - webnet

  redis:
    image: "redis:alpine"
    ports:
      - "6379:6379"
    networks:
      - webnet

networks:
  webnet:
```

## Polecenia compose

```bash
# Uruchom w tle
docker-compose up -d

# Uruchom (foreground)
docker-compose up

# Zbuduj i uruchom
docker-compose up --build

# Zatrzymaj
docker-compose down

# Zatrzymaj i usuń wolumeny
docker-compose down -v

# Restart
docker-compose restart

# Logs
docker-compose logs
docker-compose logs -f

# Exec
docker-compose exec web bash

# Skala
docker-compose up --scale web=3
```

## Zmienne środowiskowe

```bash
# Plik .env
POSTGRES_USER=alicja
POSTGRES_PASSWORD=sekret
POSTGRES_DB=moja_baza

# docker-compose.yml
services:
  db:
    image: postgres:15
    environment:
      - POSTGRES_USER=${POSTGRES_USER}
      - POSTGRES_PASSWORD=${POSTGRES_PASSWORD}
```

## Health checks

```yaml
services:
  web:
    build: .
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:5000/health"]
      interval: 30s
      timeout: 10s
      retries: 3
      start_period: 5s
```

## Powiązane

- [[05-Volumes_PL]] - Poprzednie: Wolumeny
- [[07-Podman_PL]] - Następne: Podman
- [[06-Docker-Compose]] w [[../Ansible-Concepts/index_PL]] - Provisioning

## Następne kroki

Przejdź do [[07-Podman_PL]] aby dowiedzieć się o alternatywie dla Docker.
