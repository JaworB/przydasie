# Konteneryzacja

Najlepsze praktyki i bezpieczeństwo w konteneryzacji.

## Najlepsze praktyki

### Minimalizacja obrazów

```dockerfile
# Używaj slim/alpine
FROM python:3.11-slim

# Usuwaj cache
RUN apt-get update && apt-get install -y --no-install-recommends \
    package && \
    rm -rf /var/lib/apt/lists/*
```

### Bezpieczeństwo

```dockerfile
# Nie uruchamiaj jako root
RUN groupadd -r appgroup && useradd -r -g appgroup appuser
USER appuser

# Nie używaj hasłowanych obrazów
# Używaj SHA256 zamiast tagów
FROM python@sha256:abc123...
```

### Multi-stage builds

```dockerfile
# Build stage
FROM python:3.11 AS builder
RUN pip install --no-cache-dir -r requirements.txt

# Production stage
FROM python:3.11-slim
COPY --from=builder /usr/local/lib/python3.11/site-packages /usr/local/lib/python3.11/site-packages
COPY app.py .
CMD ["python", "app.py"]
```

## Bezpieczeństwo

```bash
# Skanuj obraz
trivy image moja-aplikacja

docker scout cves moja-aplikacja

# Skanuj pod kątem sekretów
gitleaks detect --source=.
```

## Ograniczenia kontenera

```bash
# Limit pamięci
docker run -m 512m moja-aplikacja

# Limit CPU
docker run --cpus=1.5 moja-aplikacja

# Read-only filesystem
docker run --read-only moja-aplikacja

# No new privileges
docker run --security-opt=no-new-privileges moja-aplikacja
```

## .dockerignore

```
.git
.gitignore
README.md
tests/
docs/
*.md
.env
__pycache__
*.pyc
.dockerignore
Dockerfile
docker-compose.yml
```

## Monitoring

```bash
# Stats
docker stats

# Events
docker events

# System
docker system df
docker system prune
```

## Powiązane

- [[07-Podman_PL]] - Poprzednie: Podman
- [[09-Cheatsheet_PL]] - Następne: Ściągawka
- [[08-Containerization]] w [[../Ansible-Concepts/index_PL]] - Ansible dla kontenerów

## Następne kroki

Przejdź do [[09-Cheatsheet_PL]] do szybkiej referencji poleceń.
