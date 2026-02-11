# Podstawowe koncepcje

Podstawowe koncepcje Git, które każdy programista musi zrozumieć.

## Repozytorium

**Repozytorium** (repo) to katalog projektu zawierający wszystkie pliki projektu i dane śledzenia Git.

```
projekt/
├── .git/          # Ukryty folder z danymi Git
├── src/           # Twój kod źródłowy
└── README.md      # Dokumentacja
```

**Typy:**
- **Lokalne repo**: Folder `.git` na twojej maszynie
- **Zdalne repo**: Serwer (GitHub, GitLab) hostujący projekt

## Commit

**Commit** to migawka twojego projektu w określonym momencie czasowym.

```
A---B---C---D---E  (gałąź główna)
```

Każdy commit zawiera:
- **Hash SHA-1**: Unikalny identyfikator (np. `a1b2c3d`)
- **Autor**: Kto wprowadził zmianę
- **Data**: Kiedy to zostało zrobione
- **Wiadomość**: Opis zmian
- **Rodzic**: Poprzedni commit
- **Pliki**: Migawka stanu projektu

## Branch

**Gałąź** to niezależna linia rozwoju.

```
main:     A---B---C---D---E
                     \
feature:        F---G---H---I
```

**Kluczowe gałęzie:**
- **main/master**: Główna stabilna gałąź
- **develop**: Gałąź integracji dla funkcji
- **feature/**: Nowy rozwój funkcji
- **bugfix/**: Poprawki błędów
- **hotfix/**: Awaryjne poprawki produkcyjne

## HEAD

**HEAD** to wskaźnik do twojej aktualnej lokalizacji (bieżący commit).

```
HEAD -> main -> E
```

Lub gdy na gałęzi:
```
HEAD -> feature -> I
```

**Odłączony HEAD**: Gdy checkoutujesz konkretny commit (nie gałąź):
```
HEAD (detached) -> C
```

## Katalog roboczy

**Katalog roboczy** zawiera twoje rzeczywiste pliki projektu - to co widzisz i edytujesz.

```
+-------------------+
|   Katalog roboczy |
|  (twoje pliki)    |
|  index.html       |
|  style.css        |
|  app.js           |
+-------------------+
```

## Obszar przenoszenia (Index)

**Obszar przenoszenia** to miejsce, gdzie przygotowujesz zmiany przed commitowaniem.

```
+-------------------+      git add       +-------------------+
|   Katalog roboczy |  ----------------> |   Obszar staging  |
|  (twoje pliki)    |                    |   (Index)        |
+-------------------+                    +-------------------+
```

## Diagram architektury Git

```
+-------------------+
|   Repozytorium zdalne |
|  (GitHub/GitLab) |
|                  |
+---------+---------+
          |
          | git push / git pull
          v
+---------+---------+
|    Repozytorium lokalne  |
|  (folder .git)    |
|  - Commits       |
|  - Branches      |
|  - Tags          |
+---------+---------+
          |
          | git commit
          v
+---------+---------+
|   Obszar staging     |
|     (Index)       |
|  - Pliki stage'owane |
+---------+---------+
          |
          | git add
          v
+---------+---------+
|  Katalog roboczy|
|    (twoje pliki)   |
+-------------------+
```

## Powiązane

- Zobacz [[03-Git-Internals_PL]] jak Git przechowuje dane
- Zobacz [[05-Basic-Workflow_PL]] używanie tych koncepcji
- Zobacz [[08-Branching_PL]] zarządzanie gałęziami

## Następne kroki

Przejdź do [[03-Git-Internals_PL]] aby zrozumieć jak Git przechowuje dane wewnętrznie.
