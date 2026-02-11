# Interaktywny Rebase

Przepisz historię commitów interaktywnie.

## git rebase -i

Rozpocznij interaktywny rebase.

```bash
# Rozpocznij interaktywny rebase
git rebase -i HEAD~N

# Lub od konkretnego commitu
git rebase -i abc1234
```

**Polecenia w trybie interaktywnym:**

| Polecenie | Opis |
|-----------|------|
| `pick` | Zachowaj commit bez zmian |
| `reword` | Zmień wiadomość commitu |
| `edit` | Zatrzymaj się na tym commicie do zmiany |
| `squash` | Połącz z poprzednim commitem |
| `fixup` | Jak squash ale odrzuć wiadomość |
| `drop` | Usuń commit |
| `exec` | Uruchom polecenie powłoki |

## Squashowanie commitów

**Przed rebase:**
```
pick Dodaj model użytkownika
pick Dodaj API logowania
pick Napraw literówkę
pick Dodaj wylogowanie
```

**Po rebase:**
```
pick Dodaj model użytkownika
fixup Dodaj API logowania
fixup Napraw literówkę
pick Dodaj wylogowanie
```

**Wynik:** Wszystkie połączone w jeden commit "Dodaj model użytkownika"

## Zmiana wiadomości commitu

```
pick a1b2c3d Dodaj model użytkownika
reword d4e5f6g Dodaj API logowania  <-- edytor otwiera się, zmień wiadomość
pick g7h8i9j Dodaj wylogowanie
```

## Edycja pojedynczego commitu

```
edit a1b2c3d Dodaj model użytkownika
# Git zatrzymuje się na tym commicie

# Wprowadź zmiany
git add zapomniany-plik.txt
git commit --amend

# Kontynuuj rebase
git rebase --continue
```

## Opcje git rebase

```bash
# Przerwij rebase
git rebase --abort

# Pomiń commit
git rebase --skip

# Kontynuuj po konfliktach
git rebase --continue

# Rebase na inną bazę
git rebase --onto nowa_baza stara_baza gałąź

# Rebase interaktywny
git rebase -i HEAD~10
```

## Powiązane

- Zobacz [[07-Undo-Fix_PL]] inne sposoby modyfikacji historii
- Zobacz [[08-Branching_PL]] strategie scalania
- Zobacz [[10-Git-Bisect_PL]] wyszukiwanie błędów w historii

## Następne kroki

Przejdź do [[10-Git-Bisect_PL]] aby nauczyć się o wyszukiwaniu binarne
