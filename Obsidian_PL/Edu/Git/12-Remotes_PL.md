# Operacje zdalne

Pracuj ze zdalnymi repozytoriami.

## git remote

Zarządzaj zdalnymi repozytoriami.

```bash
# Wylistuj zdalne
git remote -v

# Dodaj zdalne
git remote add origin git@github.com:użytkownik/repo.git

# Zmień nazwę zdalnego
git remote rename origin upstream

# Usuń zdalne
git remote remove origin

# Zmień URL zdalnego
git remote set-url origin nowy-url

# Pokaż szczegóły zdalnego
git remote show origin
```

## git push

Wyślij commity do zdalnego.

```bash
# Wyślij do zdalnego
git push origin main

# Ustaw upstream i wyślij
git push -u origin gałąź-funkcja

# Wyślij wszystkie gałęzie
git push --all origin

# Wyślij tagi
git push origin v1.0.0
git push --tags

# Usuń zdalną gałąź
git push origin --delete gałąź-funkcja

# Wymuś push
git push --force

# ⚠️ OSTRZEŻENIE: Nigdy nie wymuszaj push na main!
```

## git fetch

Pobierz obiekty bez scalającego.

```bash
# Pobierz ze wszystkich zdalnych
git fetch

# Pobierz z konkretnego zdalnego
git fetch origin

# Pobierz i usuń nieistniejące referencje
git fetch --prune

# Pobierz z tagami
git fetch --tags
```

## git pull

Pobierz i scal.

```bash
# Pull (fetch + merge)
git pull origin main

# Pull z rebase
git pull --rebase origin main

# Pull i przerwij na konfliktach
git pull --abort
```

## git clone

Kopiuj zdalne repozytorium.

```bash
# Klonuj przez SSH
git clone git@github.com:użytkownik/repo.git

# Klonuj przez HTTPS
git clone https://github.com/użytkownik/repo.git

# Płytki klon
git clone --depth 1 url
```

## Diagram przepływu pracy zdalnej

```
Repozytorium lokalne              Repozytorium zdalne (origin)
     |                                      |
     |   git push                   |
     |----------------------------->|  Push commitów
     |                                      |
     |   git fetch                  |
     |<-----------------------------|  Pobierz obiekty
     |                                      |
     |   git merge                  |
     |   (w .git/refs/heads/)      |
     |                                      |
```

## Powiązane

- Zobacz [[04-Getting-Started_PL]] init i clone
- Zobacz [[08-Branching_PL]] operacje gałęzi
- Zobacz [[Git-GitHub-Workflow/index_PL]] przepływy pracy specyficzne dla GitHub

## Następne kroki

Przejdź do [[13-Tags_PL]] aby nauczyć się o oznaczaniu commitów.
