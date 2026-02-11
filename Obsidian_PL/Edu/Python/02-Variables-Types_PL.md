# Zmienne i typy

Dynamiczne typowanie i typy danych w Pythonie.

## Zmienne

```python
# Przypisanie
x = 5
imie = "Alicja"
pi = 3.14159
prawda = True

# Wielokrotne przypisanie
a, b, c = 1, 2, 3

# Wymiana zmiennych
a, b = b, a
```

## Typy danych

| Typ | Przykład | Opis |
|-----|----------|------|
| `int` | `5`, `-3`, `42` | Liczby całkowite |
| `float` | `3.14`, `-0.5` | Liczby zmiennoprzecinkowe |
| `str` | `"tekst"`, `'hello'` | Ciągi znaków |
| `bool` | `True`, `False` | Wartości logiczne |
| `list` | `[1, 2, 3]` | Lista (zmienna) |
| `tuple` | `(1, 2, 3)` | Krotka (niezmienna) |
| `dict` | `{"klucz": "wartosc"}` | Słownik |
| `set` | `{1, 2, 3}` | Zbiór |

## Konwersja typów

```python
# Konwersja
int("5")       # 5
float("3.14")   # 3.14
str(42)        # "42"
bool(1)        # True
list((1, 2, 3))  # [1, 2, 3]
```

## Sprawdzanie typów

```python
x = 5
type(x) == int           # True
isinstance(x, int)       # True
```

## Powiązane

- [[01-Introduction_PL]] - Poprzednie: Wprowadzenie
- [[03-Functions_PL]] - Następne: Funkcje
- [[04-Data-Structures_PL]] - Struktury danych

## Następne kroki

Przejdź do [[03-Functions_PL]] aby dowiedzieć się o funkcjach.
