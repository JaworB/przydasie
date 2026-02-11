# Rozpoczęcie pracy

Zainicjuj lub sklonuj repozytorium Git.

## git init

Zainicjuj nowe repozytorium Git.

```bash
# Utwórz nowe repozytorium
git init

# Utwórz w konkretnym katalogu
git init mój-projekt

# Opcje:
--initial-branch=NAZWA     # Ustaw początkową nazwę gałęzi
--bare                    # Utwórz puste repozytorium (dla serwerów)
-q, --quiet               # Ukryj wyjście
```

**Przykład:**
```bash
$ git init mój-projekt
Initialized empty Git repository in /home/user/mój-projekt/.git/
```

## git clone

Skopiuj istniejące repozytorium zdalne.

```bash
# Klonuj przez HTTPS
git clone https://github.com/użytkownik/repo.git

# Klonuj przez SSH
git clone git@github.com:użytkownik/repo.git

# Klonuj do konkretnego katalogu
git clone url mój-projekt

# Klonuj konkretną gałąź
git clone -b nazwa-gałęzi url

# Klonuj z głębokością (płytki klon)
git clone --depth 1 url
```

**Przykład:**
```bash
$ git clone git@github.com:użytkownik/przydasie.git
Cloning into 'przydasie'...
remote: Enumerating objects: 100, done.
Receiving objects: 100% (100/100), 1.2 MB, done.
```

## Powiązane

- Zobacz [[02-Core-Concepts_PL]] dla koncepcji repozytorium
- Zobacz [[05-Basic-Workflow_PL]] następne kroki po init/clone
- Zobacz [[12-Remotes_PL]] dla operacji zdalnych

## Następne kroki

Przejdź do [[05-Basic-Workflow_PL]] aby nauczyć się podstawowego przepływu pracy Git.
