# Cofanie i naprawianie

Polecenia do cofania i naprawiania błędów w Git.

## git restore

Przywróć pliki z index lub commitu.

```bash
# Przywróć z obszaru przenoszenia
git restore --staged ścieżka/do/pliku

# Przywróć z ostatniego commitu
git restore ścieżka/do/pliku

# Przywróć do konkretnego commitu
git restore --source=abc1234 ścieżka/do/pliku

# Przywróć wszystkie pliki
git restore .
```

**Przykład:**
```bash
$ git status
Changes not staged for commit:
  modified:   src/config.js

$ git restore src/config.js
# Plik jest teraz w stanie ostatniego commita
```

## git reset

Przenieś HEAD do poprzedniego commitu.

```bash
# Reset miękki (zachowaj zmiany stage'owane)
git reset --soft HEAD~1

# Reset mieszany (domyślny, zachowaj zmiany w katalogu roboczym)
git reset HEAD~1

# Reset twardy (odrzuć wszystkie zmiany)
git reset --hard HEAD~1

# Reset do konkretnego commitu
git reset --hard abc1234

# Reset tylko konkretnych plików
git reset HEAD~1 -- ścieżka/do/pliku
```

**Typy resetu:**
| Typ | Zmiany stage | Katalog roboczy | Historia |
|-----|--------------|-----------------|----------|
| `--soft` | Zachowane | Zachowane | Zmieniona |
| `--mixed` | Wyczyszczone | Zachowane | Zmieniona |
| `--hard` | Wyczyszczone | Odrzucone | Zmieniona |

**Reset vs Revert:**

| Reset | Revert |
|-------|--------|
| Przepisuje historię | Tworzy nowy commit |
| Zmienia wskaźnik commitu | Zachowuje historię |
| Niebezpieczne na współdzielonych gałęziach | Bezpieczne dla współpracy |

## git revert

Utwórz nowy commit, który cofa zmiany.

```bash
# Cofnij ostatni commit
git revert HEAD

# Cofnij konkretny commit
git revert abc1234

# Cofnij bez auto-commit
git revert --no-commit abc1234
git revert --continue

# Cofnij commit merge
git revert -m 1 abc1234
```

**Przykład:**
```bash
$ git log --oneline
a1b2c3d Dodaj funkcję (bieżący)
d4e5f6g Napraw błąd

$ git revert a1b2c3d
[main f6g7h8i] Revert "Dodaj funkcję"
```

## git commit --amend

Zmodyfikuj ostatni commit.

```bash
# Zmień wiadomość ostatniego commitu
git commit --amend -m "Nowa wiadomość"

# Dodaj pliki do ostatniego commitu
git add zapomniany-plik.txt
git commit --amend --no-edit

# Zmień autora
git commit --amend --author="Nazwa <email>"
```

**⚠️ OSTRZEŻENIE: Nie zmieniaj publicznych commitów!**

## git clean

Usuń nieśledzone pliki.

```bash
# Podgląd co zostanie usunięte
git clean --dry-run
git clean -n

# Usuń nieśledzone pliki
git clean -f

# Usuń nieśledzone katalogi
git clean -fd

# Usuń ignorowane pliki
git clean -fX

# Usuń wszystko (włącznie z ignorowanymi)
git clean -fx
```

## Powiązane

- Zobacz [[05-Basic-Workflow_PL]] standardowy przepływ pracy
- Zobacz [[09-Rebase_PL]] przepisywanie historii interaktywnie
- Zobacz [[08-Branching_PL]] operacje scalania

## Następne kroki

Przejdź do [[08-Branching_PL]] aby dowiedzieć się o zarządzaniu gałęziami i scalaniu.
