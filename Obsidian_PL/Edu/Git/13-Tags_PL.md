# Tagi

Oznacz konkretne commity (wydawnictwa).

## Lekki tag

```bash
# Utwórz lekki tag
git tag v1.0.0

# Wylistuj tagi
git tag

# Wylistuj ze wzorcem
git tag -l "v1.*"

# Usuń tag
git tag -d v1.0.0
```

## Tag adnotowany

```bash
# Utwórz tag adnotowany (przechowywany w bazie danych Git)
git tag -a v1.0.0 -m "Wersja wydawnicza 1.0.0"

# Pokaż tag
git show v1.0.0

# Utwórz tag z konkretnego commitu
git tag -a v1.0.0 abc1234

# Podpisz tag (GPG)
git tag -s v1.0.0 -m "Podpisane wydanie"

# Zweryfikuj tag
git tag -v v1.0.0
```

## Wysyłanie tagów

```bash
# Wyślij pojedynczy tag
git push origin v1.0.0

# Wyślij wszystkie tagi
git push --tags

# Usuń zdalny tag
git push origin --delete v1.0.0
```

## Powiązane

- Zobacz [[12-Remotes_PL]] wysyłanie tagów do zdalnego
- Zobacz [[16-Cheatsheet_PL]] szybka referencja
- Zobacz [[05-Basic-Workflow_PL]] przepływ pracy commitów

## Następne kroki

Przejdź do [[14-Aliases_PL]] aby nauczyć się o aliasach Git.
