# Git Bisect

Wyszukiwanie binarne commitu, który wprowadził błąd.

## Jak to działa

```
Zakres wyszukiwania: 100 commitów

Krok 1: Testuj commit 50  -> ZŁY
Krok 2: Testuj commit 25  -> DOBRY
Krok 3: Testuj commit 37  -> ZŁY
Krok 4: Testuj commit 31  -> DOBRY
Krok 5: Testuj commit 34  -> ZŁY
Znaleziono: Pierwszy zły commit na pozycji 34
```

## Ręczny Bisect

```bash
# Rozpocznij bisect
git bisect start

# Oznacz bieżący commit jako zły
git bisect bad

# Oznacz znany dobry commit
git bisect good v1.0.0

# Git sprawdza środkowy commit
# ... testuj kod ...

# Oznacz wynik
git bisect good    # lub git bisect bad

# Powtarzaj aż Git znajdzie

# Zakończ bisect
git bisect reset
```

## Zautomatyzowany Bisect

```bash
# Uruchom test automatycznie
git bisect start
git bisect bad
git bisect good v1.0.0
git bisect run ./test.sh

# Kody wyjścia:
# 0 = dobry (test przeszedł)
# 1 = zły (test nie przeszedł)
# 125 = pomiń ten commit
```

**Przykładowy skrypt testowy:**
```bash
#!/bin/bash
# test.sh - Uruchom testy i wyjdź z kodem
npm test
exit $?
```

## Referencja poleceń

| Polecenie | Opis |
|-----------|------|
| `git bisect start` | Rozpocznij sesję bisect |
| `git bisect bad` | Oznacz bieżący jako zły |
| `git bisect good <commit>` | Oznacz commit jako dobry |
| `git bisect skip <commit>` | Pomiń commit |
| `git bisect run <skrypt>` | Zautomatyzowane testowanie |
| `git bisect reset` | Zakończ sesję |
| `git bisect log` | Pokaż historię bisect |

## Przykładowa sesja

```bash
$ git bisect start
Bisecting: 12 commits left to test after this (roughly 4 steps)

$ git bisect bad
Bisecting: 12 commits left to test (roughly 4 steps)

$ git bisect good v1.0.0
Bisecting: 6 commits left to test (roughly 3 steps)

# Git sprawdza commit abc1234
# ... uruchom testy ...
$ npm test
Testy nie powiodły się!

$ git bisect bad
Bisecting: 3 commits left to test (roughly 2 steps)

# Git sprawdza commit def5678
# ... uruchom testy ...
$ npm test
Testy powiodły się!

$ git bisect good
abc1234 to pierwszy zły commit
```

## Powiązane

- Zobacz [[09-Rebase_PL]] przepisywanie historii
- Zobacz [[06-Inspection_PL]] przeglądanie historii commitów
- Zobacz [[16-Cheatsheet_PL]] szybka referencja

## Następne kroki

Przejdź do [[11-Stashing_PL]] aby nauczyć się o zapisywaniu pracy w toku.
