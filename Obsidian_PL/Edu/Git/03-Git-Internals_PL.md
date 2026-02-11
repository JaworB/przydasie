# Wnętrze Git

Zrozumienie jak Git przechowuje dane wewnętrznie.

## Hash SHA-1

Git używa **SHA-1** (Secure Hash Algorithm 1) do tworzenia unikalnych identyfikatorów.

```bash
# Każdy obiekt otrzymuje 40-znakowy hash szesnastkowy
a1b2c3d4e5f6789abcdef0123456789abcdefwsze kilka01

# Pier znaków zwykle wystarczy
a1b2c3d
```

**Dlaczego SHA-1?**
- Unikalny identyfikator dla każdego obiektu
- Magazynowanie adresowalne przez zawartość
- Weryfikacja integralności

## Obiekty Git

Git przechowuje wszystko jako jeden z czterech typów obiektów:

### Blob (Binary Large Object)

Przechowuje zawartość pliku (nie metadane).

```
Hash = SHA1("zawartość pliku")
```

### Tree

Przechowuje strukturę katalogów i odniesienia do plików.

```
tree/
  ├── plik1.txt (blob)
  ├── plik2.txt (blob)
  └── podkatalog/   (tree)
```

### Commit

Łączy drzewa z metadanymi.

```
commit
  ├── tree: migawka projektu
  ├── parent: poprzedni commit
  ├── author: kto to napisał
  ├── committer: kto to zastosował
  └── message: opis
```

### Tag

Oznacza konkretny commit (używane dla wydań).

```
tag: v1.0.0 -> commit ABC123
```

## Magazyn obiektów

```
.git/
├── objects/
│   ├── a1/
│   │   └── b2c3d4...  (skompresowany blob)
│   ├── b2/
│   │   └── c3d4e5...  (skompresowany commit)
│   ├── info/          # Informacje o obiektach
│   └── pack/          # Spakowane obiekty
├── refs/
│   ├── heads/         # Odniesienia do gałęzi
│   └── tags/          # Odniesienia do tagów
└── HEAD               # Bieżący HEAD
```

## Powiązane

- Zobacz [[02-Core-Concepts_PL]] dla koncepcji reprezentowanych przez te obiekty
- Zobacz [[06-Inspection_PL]] przeglądanie obiektów za pomocą git show
- Zobacz [[04-Getting-Started_PL]] rozpoczęcie używania Git

## Następne kroki

Przejdź do [[04-Getting-Started_PL]] aby nauczyć się jak zainicjować lub sklonować repozytorium.
