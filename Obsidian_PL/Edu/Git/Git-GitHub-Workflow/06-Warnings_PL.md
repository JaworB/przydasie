# Ostrzeżenia

Ważne ostrzeżenia i czego unikać.

## ⚠️ Nigdy nie rób

### Push i commit

| Nie rób | Zamiast tego |
|---------|--------------|
| `git push --force` na współdzielonych gałęziach | `git push --force-with-lease` |
| Commituj sekretne dane | Używaj `.gitignore` i `.env` |
| Commituj pliki konfiguracyjne z hasłami | Używaj zmiennych środowiskowych |
| Commituj pliki tymczasowe | Dodaj do `.gitignore` |

### Reset i clean

| Nie rób | Zamiast tego |
|---------|--------------|
| `git reset --hard` bez kopii zapasowej | `git stash` przed reset |
| `git clean -fd` bez sprawdzenia | `git clean -n` (symulacja) |
| `git reset --hard` na publicznych commitach | Używaj `git revert` |

### Branch i merge

| Nie rób | Zamiast tego |
|---------|--------------|
| Merge bez przeglądu | Utwórz PR i przeglądaj |
| Usuń nieściągnięte gałęzie | Sprawdź `git branch --merged` |
| Rebase na współdzielonych gałęziach | Tylko na lokalnych gałęziach |

## ⚠️ Ryzykowne operacje

### git push --force

```
ZMIENIA HISTORIĘ!
Może nadpisać commity innych osób.
Używaj tylko na prywatnych gałęziach.
```

### git reset --hard

```
TRACI WSZYSTKIE NIEZACOMMITOWANE ZMIANY!
Zawsze stashuj przed użyciem.
```

### git filter-branch / BFG

```
PRZEPISUJE HISTORIĘ!
Wszyscy współpracownicy muszą przebudować.
GitHub może buforować stare dane.
```

## Jak się ratować

### Przypadkowy force push

```bash
# Znajdź stare commity
git reflog

# Przywróć
git reset --hard HEAD@{N}
```

### Przypadkowy hard reset

```bash
# Znajdź zmiany
git reflog

# Przywróć stan
git reset --hard HEAD@{1}
```

### Przypadkowy commit sekretów

```bash
# Usuń z stage
git reset HEAD plik-z-sekretem

# Cofnij zmiany
git checkout -- plik-z-sekretem

# Następnie usuń z historii (BFG)
bfg --delete-files plik-z-sekretem
```

## Powiązane

- Zobacz [[03-Securing-Data_PL]] zabezpieczanie danych
- Zobacz [[04-Removing-Credentials_PL]] usuwanie sekretów
- Zobacz [[07-Best-Practices_PL]] najlepsze praktyki
