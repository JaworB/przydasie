# Schowek

Zapisz zmiany bez commitowania.

## git stash

Zapisz zmiany bez commitowania.

```bash
# Zapisz bieżące zmiany
git stash

# Zapisz z wiadomością
git stash save "Praca w toku"

# Zapisz nieśledzone pliki -u
git stash --include-untracked
```

## git stash pop

```bash
# Zastosuj ostatni schowek i usuń go
git stash pop

# Zastosuj konkretny schowek
git stash pop stash@{2}

# Zastosuj bez usuwania
git stash apply
git stash apply stash@{1}
```

## git stash list

```bash
# Wylistuj wszystkie schowki
git stash list

# Pokaż zawartość schowka
git stash show
git stash show -p
```

## git stash drop

```bash
# Usuń ostatni schowek
git stash drop

# Usuń konkretny schowek
git stash drop stash@{2}

# Wyczyść wszystkie schowki
git stash clear
```

## Częściowe schowanie

```bash
# Schowaj konkretne pliki
git stash push ścieżka/do/pliku1 ścieżka/do/pliku2

# Schowaj interaktywnie
git stash push -p
# Wybierz fragmenty:
# y - schowaj ten fragment
# n - nie schowuj tego fragmentu
# q - wyjdź
# a - schowaj wszystkie pozostałe
```

## Przykładowy przepływ pracy

```bash
$ git status
On branch feature/logowanie
Changes to be committed:
  new file:   src/auth.js

Changes not staged for commit:
  modified:   src/config.js

Untracked files:
  debug.log

# Schowaj wszystko
$ git stash -u -m "WIP: Funkcja uwierzytelniania"

$ git status
On branch feature/logowanie
nothing to commit (clean)

# ... przełącz na inną gałąź ...
$ git checkout main

# ... wykonaj pracę ...

# ... wróć do funkcji ...
$ git checkout feature/logowanie
$ git stash pop
# Zmiany przywrócone!
```

## Powiązane

- Zobacz [[05-Basic-Workflow_PL]] normalny przepływ pracy
- Zobacz [[07-Undo-Fix_PL]] inne sposoby obsługi zmian
- Zobacz [[16-Cheatsheet_PL]] szybka referencja

## Następne kroki

Przejdź do [[12-Remotes_PL]] aby nauczyć się o operacjach zdalnych.
