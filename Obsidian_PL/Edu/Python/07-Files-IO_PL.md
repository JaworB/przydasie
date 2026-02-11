# Pliki I/O

Otwieranie, odczytywanie i zapisywanie plików w Pythonie.

## Otwieranie plików

```python
# Odczyt
with open("plik.txt", "r", encoding="utf-8") as f:
    zawartosc = f.read()

# Zapis
with open("nowy.txt", "w", encoding="utf-8") as f:
    f.write("Nowa treść\n")

# Dodawanie
with open("log.txt", "a", encoding="utf-8") as f:
    f.write("Nowa linia\n")
```

## Tryby otwierania

| Tryb | Opis |
|------|------|
| `r` | Odczyt (domyślny) |
| `w` | Zapis (nadpisuje) |
| `a` | Dodawanie |
| `r+` | Odczyt i zapis |
| `b` | Tryb binarny |

## Metody odczytu

```python
with open("plik.txt", "r") as f:
    # Cały plik
    tekst = f.read()
    
    # Linia po linii
    for linia in f:
        print(linia.strip())
    
    # Wszystkie linie
    linie = f.readlines()
```

## Ścieżki

```python
import pathlib

# Ścieżka bezwzględna
sciezka = pathlib.Path("/home/user/plik.txt")

# Ścieżka względna
sciezka = pathlib.Path("dane/wejscie.txt")

# Operacje
sciezka.exists()       # Czy istnieje
sciezka.is_file()      # Czy to plik
sciezka.is_dir()       # Czy to katalog
sciezka.parent         # Katalog nadrzędny
sciezka.name           # Nazwa pliku
```

## JSON

```python
import json

# Zapis
dane = {"imie": "Alicja", "wiek": 30}
with open("dane.json", "w") as f:
    json.dump(dane, f, indent=2)

# Odczyt
with open("dane.json", "r") as f:
    dane = json.load(f)
```

## Powiązane

- [[06-OOP_PL]] - Poprzednie: Programowanie obiektowe
- [[08-Virtual-Environments_PL]] - Następne: Środowiska wirtualne
- [[07-Files-IO]] w [[../JavaScript/index_PL]] - Pliki w JavaScript

## Następne kroki

Przejdź do [[08-Virtual-Environments_PL]] aby dowiedzieć się o środowiskach wirtualnych.
