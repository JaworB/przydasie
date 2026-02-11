# Ściągawka

Szybka referencja poleceń Docker.

## Obrazy

| Polecenie | Opis |
|-----------|------|
| `docker build -t name .` | Zbuduj obraz |
| `docker images` | Lista obrazów |
| `docker rmi name` | Usuń obraz |
| `docker pull name` | Pobierz obraz |
| `docker push name` | Wyślij obraz |
| `docker tag src dst` | Otaguj obraz |

## Kontenery

| Polecenie | Opis |
|-----------|------|
| `docker run name` | Uruchom kontener |
| `docker run -d name` | Uruchom w tle |
| `docker run -p 8080:80` | Mapowanie portów |
| `docker run -v vol:/data` | Montuj wolumen |
| `docker run -e VAR=value` | Zmienna środowiskowa |
| `docker ps` | Lista kontenerów |
| `docker stop name` | Zatrzymaj |
| `docker start name` | Uruchom |
| `docker restart name` | Restart |
| `docker rm name` | Usuń kontener |
| `docker logs name` | Pokaż logi |
| `docker exec name cmd` | Wykonaj polecenie |

## Wolumeny

| Polecenie | Opis |
|-----------|------|
| `docker volume create` | Utwórz wolumen |
| `docker volume ls` | Lista wolumenów |
| `docker volume rm` | Usuń wolumen |
| `docker volume inspect` | Szczegóły |

## Sieci

| Polecenie | Opis |
|-----------|------|
| `docker network create` | Utwórz sieć |
| `docker network ls` | Lista sieci |
| `docker network rm` | Usuń sieć |

## Docker Compose

| Polecenie | Opis |
|-----------|------|
| `docker-compose up -d` | Uruchom |
| `docker-compose down` | Zatrzymaj |
| `docker-compose up --build` | Zbuduj i uruchom |
| `docker-compose logs -f` | Logi |
| `docker-compose exec svc cmd` | Exec |

## docker-compose.yml

```yaml
version: '3'
services:
  app:
    build: .
    ports:
      - "80:8000"
    environment:
      - DB_HOST=db
    depends_on:
      - db
  db:
    image: postgres:15
    environment:
      - POSTGRES_DB=app
```

## Powiązane

- [[08-Containerization_PL]] - Poprzednie: Konteneryzacja
- [[10-Lazydocker_PL]] - Następne: Lazydocker
- [[09-Cheatsheet]] w [[../Skrypty-Bash/index_PL]] - Ściągawka Bash

## Następne kroki

Przejdź do [[10-Lazydocker_PL]] aby dowiedzieć się o interfejsie UI dla Docker.
