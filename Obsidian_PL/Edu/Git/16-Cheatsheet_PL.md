# Ściągawka

Szybka referencja poleceń Git.

## Konfiguracja i początek

| Polecenie | Opis |
|-----------|------|
| `git config --global user.name "Nazwa"` | Ustaw nazwę użytkownika |
| `git config --global user.email "email"` | Ustaw email |
| `git config --list` | Pokaż wszystkie ustawienia |

## Rozpoczęcie pracy

| Polecenie | Opis |
|-----------|------|
| `git init` | Zainicjuj repozytorium |
| `git clone url` | Klonuj repozytorium zdalne |
| `git clone -b gałąź url` | Klonuj konkretną gałąź |

## Podstawowy przepływ pracy

| Polecenie | Opis |
|-----------|------|
| `git status` | Pokaż status drzewa roboczego |
| `git add .` | Stage'uj wszystkie zmiany |
| `git add plik` | Stage'uj konkretny plik |
| `git commit -m "msg"` | Commitni stage'owane zmiany |
| `git commit -am "msg"` | Stage'uj i commituj wszystko |

## Gałęzie

| Polecenie | Opis |
|-----------|------|
| `git branch` | Wylistuj gałęzie |
| `git branch nazwa` | Utwórz gałąź |
| `git checkout -b nazwa` | Utwórz i przełącz |
| `git switch nazwa` | Przełącz gałąź |
| `git branch -d nazwa` | Usuń gałąź |

## Scalanie

| Polecenie | Opis |
|-----------|------|
| `git merge gałąź` | Scal do bieżącej |
| `git merge --no-ff gałąź` | Bez fast-forward |
| `git merge --abort` | Przerwij scalanie |

## Operacje zdalne

| Polecenie | Opis |
|-----------|------|
| `git remote -v` | Wylistuj zdalne |
| `git remote add nazwa url` | Dodaj zdalne |
| `git push origin gałąź` | Wyślij do zdalnego |
| `git pull` | Pobierz i scal |
| `git fetch` | Pobierz obiekty |
| `git clone url` | Klonuj repozytorium |

## Inspekcja

| Polecenie | Opis |
|-----------|------|
| `git log` | Pokaż historię commitów |
| `git log --oneline` | Kompaktowa historia |
| `git log --graph` | Wizualny graf |
| `git diff` | Pokaż zmiany |
| `git show commit` | Pokaż szczegóły commitu |
| `git blame plik` | Pokaż autorów pliku |

## Cofanie

| Polecenie | Opis |
|-----------|------|
| `git restore plik` | Przywróć plik |
| `git reset --soft HEAD~1` | Cofnij commit, zachowaj zmiany |
| `git reset --hard HEAD~1` | Cofnij commit, odrzuć zmiany |
| `git revert commit` | Utwórz commit cofający |
| `git commit --amend` | Zmodyfikuj ostatni commit |
| `git clean -fd` | Usuń nieśledzone |

## Schowek

| Polecenie | Opis |
|-----------|------|
| `git stash` | Zapisz zmiany |
| `git stash pop` | Zastosuj i usuń |
| `git stash apply` | Zastosuj bez usuwania |
| `git stash list` | Wylistuj schowki |
| `git stash drop` | Usuń schowek |

## Zaawansowane

| Polecenie | Opis |
|-----------|------|
| `git rebase -i HEAD~N` | Interaktywny rebase |
| `git bisect start` | Znajdź błędny commit |
| `git tag -a v1.0 -m "msg"` | Utwórz tag |
| `git cherry-pick commit` | Kopiuj commit |

## Powiązane

- Zobacz [[01-Introduction_PL]] przegląd Git
- Zobacz [[05-Basic-Workflow_PL]] szczegółowy przepływ pracy
- Zobacz [[15-Tips-Best-Practices_PL]] rekomendacje

## Kompletny przewodnik

Wróć do [[index_PL]] do pełnego przewodnika po koncepcjach Git.
