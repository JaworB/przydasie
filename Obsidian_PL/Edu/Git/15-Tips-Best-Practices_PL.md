# Wskazówki i najlepsze praktyki

Wytyczne i rekomendacje dla efektywnego używania Git.

## Wytyczne dla commitów

| Rób | Nie rób |
|-----|---------|
| Pisz jasne, zwięzłe wiadomości | Używaj mglistych wiadomości jak "napraw" |
| Jeden logiczny commit na zmianę | Łącz niezwiązane zmiany |
| Używaj trybu rozkazującego | Używaj czasu przeszłego |
| Trzymaj temat < 50 znaków | Pisz długie tematy |
| Odnos się do zadań (#123) | Nie odnoś się do zadań |

## Nazewnictwo gałęzi

**Konwencje:**
```
feature/nazwa          # Nowa funkcja
bugfix/nazwa           # Poprawka błędu
hotfix/nazwa           # Awaryjna poprawka
release/wersja         # Przygotowanie wydania
docs/nazwa            # Dokumentacja
refactor/nazwa        # Restrukturyzacja kodu
test/nazwa            # Testy
```

**Przykłady:**
```
feature/uwierzytelnianie-użytkownika
bugfix/crash-logowania
hotfix/poprawka-bezpieczeństwa
release/v1.0.0
docs/aktualizacja-readme
```

## Rekomendacje przepływu pracy

**Przepływ pracy gałęzi funkcji:**
```
1. Utwórz gałąź z main
2. Wykonaj commity
3. Wyślij do zdalnego
4. Utwórz pull request
5. Przeglądaj i scal
6. Usuń gałąź
```

## Użyteczne wskazówki

```bash
# Auto-korekta poleceń
git config --global help.autocorrect 1

# Kolorowe wyjście
git config --global color.ui auto

# Domyślny edytor
git config --global core.editor vim

# Końcówki linii
git config --global core.autocrlf input

# Strategia pull
git config --global pull.rebase false  # Merge
git config --global pull.rebase true   # Rebase

# Ustaw domyślną gałąź
git config --global init.defaultBranch main

# Ignoruj zmiany trybu pliku
git config --global core.fileMode false
```

## ⚠️ Ważne ostrzeżenia

| Ostrzeżenie | Zapobieganie |
|-------------|--------------|
| Wymuszony push do współdzielonej gałęzi | Nigdy `git push -f` na main/dev |
| Usunięcie niescalonej gałęzi | Użyj `git branch -d` (bezpieczne) |
| Commit wrażliwych danych | Użyj `.gitignore`, `git rm --cached` |
| Utrata commitów | Nie `git reset --hard` niezapisanej pracy |
| Konflikty scalenia | Pull często, rebase regularnie |

## Powiązane

- Zobacz [[05-Basic-Workflow_PL]] format wiadomości commit
- Zobacz [[08-Branching_PL]] nazewnictwo gałęzi
- Zobacz [[Git-GitHub-Workflow/index_PL]] zaawansowane przepływy pracy

## Następne kroki

Przejdź do [[16-Cheatsheet_PL]] do szybkiej referencji poleceń.
