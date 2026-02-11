# Inspekcja

Polecenia do przeglądania i inspekcji repozytorium.

## git log

Pokaż historię commitów.

```bash
# Podstawowa historia
git log

# Kompaktowa (jedna linia na commit)
git log --oneline

# Pokaż N commitów
git log -5

# Filtruj po autorze
git log --author="Jan"

# Filtruj po wiadomości
git log --grep="napraw błąd"

# Pokaż historię pliku
git log --follow ścieżka/do/pliku

# Pokaż zmiany
git log -p

# Pokaż podsumowanie statystyk
git log --stat

# Wizualizacja grafu
git log --graph --oneline

# Filtr czasowy
git log --since="2024-01-01"
git log --until="2024-12-31"
```

**Placeholdery formatu:**
```
%h    - Skrócony hash commit
%H    - Pełny hash commit
%s    - Temat
%b    - Treść
%ad   - Data autora
%an   - Nazwa autora
%ae   - Email autora
```

**Przykład:**
```bash
$ git log --oneline --graph
* a1b2c3d (HEAD -> main) Fix: Napraw wyciek pamięci
* d4e5f6g Merge pull request #45
|\
| * g7h8i9j feat: Dodaj warstwę cache'owania
* | h0i1j2k chore: Aktualizuj zależności
|/
* k2l3m4n feat: Panel użytkownika
```

## git diff

Pokaż zmiany między commitami, katalogiem roboczym a obszarem przenoszenia.

```bash
# Pokaż niezstage'owane zmiany
git diff

# Pokaż stage'owane zmiany
git diff --cached
git diff --staged

# Porównaj gałęzie
git diff main..feature

# Porównaj konkretne pliki
git diff ścieżka/do/pliku

# Pokaż tylko nazwy plików
git diff --name-only

# Pokaż tylko dodania/usunięcia
git diff --stat
```

**Przykład:**
```bash
$ git diff src/auth.js
diff --git a/src/auth.js b/src/auth.js
index 1234567..89abcde 100644
--- a/src/auth.js
+++ b/src/auth.js
@@ -10,5 +10,8 @@ function login(user) {
    if (!user.password) {
      throw new Error('Hasło wymagane');
    }
+  // Sprawdź czy konto jest zablokowane
+  if (user.isLocked) {
+    throw new Error('Konto zablokowane');
+  }
    return authenticate(user);
  }
```

## git show

Pokaż szczegóły konkretnego commitu lub obiektu.

```bash
# Pokaż ostatni commit
git show

# Pokaż konkretny commit
git show abc1234

# Pokaż commit z diffem
git show -p abc1234

# Pokaż plik w konkretnym commicie
git show abc1234:ścieżka/do/pliku

# Pokaż tag
git show v1.0.0
```

## git blame

Pokaż kto ostatnio modyfikował każdą linię w pliku.

```bash
# Oblicz cały plik
git blame ścieżka/do/pliku

# Oblicz z informacjami o commicie
git blame -L 10,20 ścieżka/do/pliku

# Pokaż email autora
git blame -e ścieżka/do/pliku

# Ignoruj białe znaki
git blame -w ścieżka/do/pliku
```

**Przykład:**
```bash
$ git blame src/app.js
^a1b2c3d (Alicja    2024-01-01)  import React from 'react';
^d4e5f6g (Bartek    2024-01-05)  import { useState } from 'react';
^g7h8i9j (Karolina  2024-01-10)  function App() {
h0i1j2k3 (Dawid     2024-01-15)    const [count, setCount] = useState(0);
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

# Wylistuj scalone gałęzie
git branch --merged

# Wylistuj niescalone gałęzie
git branch --no-merged

# Utwórz nową gałąź
git branch feature/logowanie

# Usuń gałąź
git branch -d feature/logowanie    # Bezpieczne usunięcie
git branch -D feature/logowanie    # Wymuszone usunięcie
```

## Powiązane

- Zobacz [[05-Basic-Workflow_PL]] przepływ pracy tworzący tę historię
- Zobacz [[08-Branching_PL]] zarządzanie gałęziami
- Zobacz [[16-Cheatsheet_PL]] szybka referencja

## Następne kroki

Przejdź do [[07-Undo-Fix_PL]] aby nauczyć się jak naprawiać błędy w Git.
