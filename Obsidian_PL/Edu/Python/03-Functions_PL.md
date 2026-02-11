# Funkcje

Definiowanie i używanie funkcji w Pythonie.

## Definicja funkcji

```python
def pozdrawiam(imie):
    return f"Cześć, {imie}!"

# Wywołanie
print(pozdrawiam("Alicja"))
```

## Parametry i argumenty

```python
# Parametry domyślne
def powitaj(imie="Gość"):
    return f"Witaj, {imie}!"

# Argumenty słownikowe
def przedstaw(imie, wiek):
    return f"{imie} ma {wiek} lat"

przedstaw(wiek=25, imie="Bartek")
```

## *args i **kwargs

```python
# *args - argumenty pozycyjne
def suma(*liczby):
    return sum(liczby)

print(suma(1, 2, 3, 4, 5))  # 15

# **kwargs - argumenty słownikowe
def info(**dane):
    for klucz, wartosc in dane.items():
        print(f"{klucz}: {wartosc}")

info(imie="Alicja", wiek=30, miasto="Warszawa")
```

## Funkcje lambda

```python
# Funkcja anonimowa
podwoj = lambda x: x * 2
print(podwoj(5))  # 10

# Z filter i map
liczby = [1, 2, 3, 4, 5]
parzyste = list(filter(lambda x: x % 2 == 0, liczby))
```

## Zakres zmiennych

```python
# Zmienna globalna
zmienna_globalna = "jestem globalna"

def funkcja():
    # Zmienna lokalna
    zmienna_lokalna = "jestem lokalna"
    print(zmienna_globalna)  # Dostęp do globalnej

# Użyj global keyword do modyfikacji
def modyfikuj():
    global x
    x = 10
```

## Powiązane

- [[02-Variables-Types_PL]] - Poprzednie: Zmienne i typy
- [[04-Data-Structures_PL]] - Następne: Struktury danych
- [[06-OOP_PL]] - Klasy i obiekty

## Następne kroki

Przejdź do [[04-Data-Structures_PL]] aby dowiedzieć się o strukturach danych.
