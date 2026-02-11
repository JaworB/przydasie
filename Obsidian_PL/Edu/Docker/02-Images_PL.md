# Obrazy

Tworzenie obrazów Docker za pomocą Dockerfile.

## Dockerfile

```dockerfile
# Obraz bazowy
FROM python:3.11-slim

# Katalog roboczy
WORKDIR /app

# Kopiuj pliki zależności
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Kopiuj kod aplikacji
COPY . .

# Port aplikacji
EXPOSE 8000

# Polecenie uruchomieniowe
CMD ["python", "app.py"]
```

## Budowanie obrazu

```bash
# Buduj obraz
docker build -t moja-aplikacja .

# Buduj z tagiem
docker build -t moja-aplikacja:v1.0 .

# Buduj z plikiem Dockerfile
docker build -f Dockerfile.prod -t moja-aplikacja:prod .
```

## Instrukcje Dockerfile

| Instrukcja | Opis |
|------------|------|
| `FROM` | Obraz bazowy |
| `RUN` | Wykonaj polecenie |
| `COPY` | Kopiuj pliki |
| `ADD` | Kopiuj (z URL/extract) |
| `WORKDIR` | Ustaw katalog roboczy |
| `ENV` | Zmienne środowiskowe |
| `EXPOSE` | Eksponuj port |
| `CMD` | Polecenie domyślne |
| `ENTRYPOINT` | Punkt wejścia |

## Najlepsze praktyki

```dockerfile
# Używaj konkretnych wersji
FROM python:3.11-slim

# Łącz polecenia RUN
RUN apt-get update && apt-get install -y --no-install-recommends \
    package1 \
    package2 \
    && rm -rf /var/lib/apt/lists/*

# Używaj .dockerignore
# .git
# __pycache__
# *.pyc
# .env
```

## Publikowanie obrazów

```bash
# Zaloguj do Docker Hub
docker login

# Taguj obraz
docker tag moja-aplikacja uzytkownik/moja-aplikacja

# Wypchnij do registry
docker push uzytkownik/moja-aplikacja

# Pobierz obraz
docker pull uzytkownik/moja-aplikacja
```

## Powiązane

- [[01-Introduction_PL]] - Poprzednie: Wprowadzenie
- [[03-Containers_PL]] - Następne: Kontenery
- [[08-Containerization_PL]] - Najlepsze praktyki

## Następne kroki

Przejdź do [[03-Containers_PL]] aby dowiedzieć się o zarządzaniu kontenerami.
