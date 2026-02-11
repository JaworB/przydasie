# Gałęzie

Zarządzaj gałęziami i scalaj zmiany.

## Diagram gałęzi

```
                    feature/logowanie
                    |
A---B---C---D---E---+---F---G---H  (main)
            \       \
             \       \
              I---J---K---L---M---N  (feature/auth)
```

## git branch

Zarządzaj gałęziami.

```bash
# Wylistuj gałęzie
git branch

# Wylistuj wszystkie gałęzie (włącznie ze zdalnymi)
git branch -a

# Wylistuj z ostatnim commitem
git branch -v

# Utwórz nową gałąź
git branch feature/logowanie

# Usuń gałąź
git branch -d feature/logowanie    # Bezpieczne usunięcie
git branch -D feature/logowanie    # Wymuszone usunięcie

# Zmień nazwę gałęzi
git branch -m stara-nazwa nowa-nazwa
```

## git checkout / git switch

Przełączaj gałęzie.

```bash
# Przełącz na istniejącą gałąź
git checkout feature-gałąź
git switch feature-gałąź

# Utwórz i przełącz
git checkout -b nowa-gałąź
git switch -c nowa-gałąź

# Przełącz na poprzednią gałąź
git checkout -
git switch -

# Odłącz HEAD (przełącz na konkretny commit)
git checkout abc1234

# Wymuś przełączanie
git checkout -f feature-gałąź
```

**⚠️ OSTRZEŻenie: Niezacommitowane zmiany mogą zostać utracone!**

## git merge

Połącz historię gałęzi.

```bash
# Scal gałąź funkcji do bieżącej gałęzi
git merge feature-gałąź

# Scalenie fast-forward
git merge feature-gałąź

# Bez fast-forward (tworzy commit scalający)
git merge --no-ff feature-gałąź

# Squash commitów
git merge --squash feature-gałąź
git commit -m "Scal funkcję"

# Przerwij scalanie
git merge --abort
```

## Typy scalania

**Scalenie fast-forward:**
```
Przed:                     Po:
A---B---C  main             A---B---C---D---E---F  main
        \                                    /
         D---E---F  feature ---------------
```

**Scalenie bez fast-forward:**
```
Przed:                     Po:
A---B---C  main             A---B---C-------G  main
        \                  /         \
         D---E---F  feature           D---E---F  feature
                                     (G = commit scalający)
```

## Rozwiązywanie konfliktów

**Gdy wystąpią konflikty:**
```
<<<<<<< HEAD
const name = "Alicja";
=======
const name = "Bartek";
>>>>>>> feature-gałąź
```

**Kroki rozwiązania:**
```bash
# 1. Otwórz plik i napraw konflikty
vim ścieżka/do/pliku

# 2. Oznacz jako rozwiązane
git add ścieżka/do/pliku

# 3. Dokończ scalanie
git commit
```

## Powiązane

- Zobacz [[07-Undo-Fix_PL]] cofanie scalonych zmian
- Zobacz [[09-Rebase_PL]] alternatywa dla scalania
- Zobacz [[16-Cheatsheet_PL]] szybka referencja poleceń

## Następne kroki

Przejdź do [[09-Rebase_PL]] aby nauczyć się o interaktywnym rebasowaniu.
