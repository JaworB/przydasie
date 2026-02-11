# Konfiguracja początkowa

Utwórz repozytorium Git i skonfiguruj pierwszy commit.

## Utwórz nowe repozytorium na GitHub

1. Idź do [GitHub](https://github.com)
2. Kliknij "+" → "New repository"
3. Wypełnij nazwę, opis
4. Wybierz public/private
5. Dodaj README (opcjonalnie)
6. Wybierz .gitignore (opcjonalnie)
7. Wybierz licencję (opcjonalnie)
8. Kliknij "Create repository"

## Klonuj istniejące repo

```bash
# Przez SSH (zalecane)
git clone git@github.com:username/repo.git

# Przez HTTPS
git clone https://github.com/username/repo.git
```

## Zainicjuj nowe repo lokalnie

```bash
# Utwórz katalog
mkdir my-project
cd my-project

# Zainicjuj Git
git init

# Utwórz plik README
echo "# My Project" > README.md

# Dodaj i commit
git add README.md
git commit -m "Initial commit"

# Dodaj zdalne
git remote add origin git@github.com:username/repo.git

# Wyślij do GitHub
git push -u origin main
```

## Pierwszy commit

```bash
# Dodaj pliki
git add .

# Commit z opisem
git commit -m "feat: Dodaj początkową strukturę projektu"

# Wyślij
git push origin main
```

## Powiązane

- Zobacz [[02-SSH-Keys_PL]] konfiguracja SSH
- Zobacz [[03-Securing-Data_PL]] zabezpieczanie danych
- Zobacz [[index_PL]] podstawy Git
