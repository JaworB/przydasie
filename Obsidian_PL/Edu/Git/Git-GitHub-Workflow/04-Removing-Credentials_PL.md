# Usuwanie sekretów z historii

Usuwanie przypadkowo zacommitowanych wrażliwych danych.

## Bfilter (zalecane)

Narzędzie do bezpiecznego usuwania sekretów z historii Git:

```bash
# Zainstaluj bfilter
pip install bfg

# Użyj BFG (szybsze niż git filter-branch)
bfg --delete-files SECRETS.txt
bfg --replace-text passwords.txt

# Wyczyśćreflog i garbage collect
git reflog expire --expire=now --all && git gc --prune=now --aggressive
```

## git filter-branch (wolniejsze)

```bash
# Usuń plik z historii
git filter-branch --force --index \
  --env-filter 'if [ "$GIT_COMMIT" = "commit-id" ]; then export GIT_AUTHOR_NAME="New Name"; fi' \
  --tag-name-filter cat -- --all

# Lub użyj filter-repo (zalecane)
git filter-repo --path-glob '*.env' --invert-paths
```

## GitHub Security Alerts

Po usunięciu:
1. GitHub automatycznie skanuje
2. Otrzymasz alert jeśli znaleziono
3. Wykonaj "Dismiss" po naprawie

## Zapobiegaj w przyszłości

- Używaj `.gitignore`
- Używaj pre-commit hooks
- Używaj GitHub Secrets dla CI/CD
- Szkol zespół

## Powiązane

- Zobacz [[03-Securing-Data_PL]] zabezpieczanie danych
- Zobacz [[06-Warnings_PL]] ostrzeżenia
- Zobacz [[07-Best-Practices_PL]] najlepsze praktyki
