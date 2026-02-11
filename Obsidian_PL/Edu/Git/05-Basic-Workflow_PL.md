# Podstawowy przepływ pracy

Podstawowy przepływ pracy Git: status, add, commit.

## git status

Pokaż status drzewa roboczego.

```bash
# Pokaż pełny status
git status

# Format skrócony
git status -s

# Pokaż informacje o gałęzi
git status -b

# Pokaż nieśledzone pliki
git status -u

# Przykładowe wyjście (pełne):
On branch main
Your branch is up to date with 'origin/main'.

Changes not staged for commit:
  modified:   src/index.js
  deleted:     lib/utils.py

Untracked files:
  new-feature/
```

**Kody statusu (-s):**
```
 M  - Zmodyfikowane w katalogu roboczym, stage'owane w index
M   - Zmodyfikowane w index, stage'owane w katalogu roboczym
??  - Nieśledzone
A   - Dodane do index
D   - Usunięte z index
```

## git add

Dodaj zmiany do obszaru przenoszenia.

```bash
# Stage'uj konkretny plik
git add ścieżka/do/pliku.txt

# Stage'uj wszystkie zmiany
git add .

# Stage'uj wszystkie zmiany (rekursywnie)
git add -A

# Stage'uj nowe i zmodyfikowane pliki (nie usunięte)
git add --update

# Interaktywne stage'owanie
git add -i

# Stage'uj części plików
git add -p

# Symulacja
git add --dry-run ścieżka/
```

**Przykład:**
```bash
$ git add src/app.js lib/utils.py
$ git status
Changes to be committed:
  new file:   src/app.js
  modified:   lib/utils.py
```

## git commit

Commitni stage'owane zmiany.

```bash
# Commit z wiadomością
git commit -m "Dodaj uwierzytelnianie użytkownika"

# Commit z wiadomością wieloliniową
git commit -m "Tytuł" -m "Opis treści"

# Zmien ostatni commit
git commit --amend

# Zmien bez zmiany wiadomości
git commit --amend --no-edit

# Commit jako inny autor
git commit --author="Nazwa <email>"

# Zmień datę commit
git commit --date="2024-01-15"

# Pomiń hooki
git commit --no-verify

# Pokaż diff w edytorze wiadomości
git commit -v
```

## Najlepsze praktyki dla wiadomości commit

**Struktura:**
```
typ(zakres): temat

treść (opcjonalna)

stopka (opcjonalna)
```

**Typy:**
- `feat`: Nowa funkcja
- `fix`: Poprawka błędu
- `docs`: Dokumentacja
- `style`: Formatowanie
- `refactor`: Restrukturyzacja
- `test`: Testowanie
- `chore`: Konserwacja

**Przykład:**
```
feat(auth): Dodaj uwierzytelnianie token JWT

Implementuj uwierzytelnianie oparte na JWT dla endpointów API.

Closes #123
Reviewed-by: @lider-zespołu
```

## Powiązane

- Zobacz [[06-Inspection_PL]] przeglądanie historii commitów
- Zobacz [[07-Undo-Fix_PL]] naprawianie błędów
- Zobacz [[02-Core-Concepts_PL]] zrozumienie obszaru przenoszenia

## Następne kroki

Przejdź do [[06-Inspection_PL]] aby nauczyć się jak przeglądać i inspekcjonować historię repozytorium.
