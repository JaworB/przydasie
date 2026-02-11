# Struktury danych

Listy, słowniki, krotki i zbiory w Pythonie.

## Lista

```python
# Tworzenie
liczby = [1, 2, 3, 4, 5]
mieszane = [1, "tekst", True, 3.14]

# Dostęp
liczby[0]      # Pierwszy element
liczby[-1]     # Ostatni element
liczby[1:3]    # Fragment [2, 3]

# Modyfikacja
liczby.append(6)      # Dodaj na końcu
liczby.insert(0, 0)  # Wstaw na pozycję
liczby.remove(3)     # Usuń pierwsze wystąpienie
liczby.pop()          # Usuń i zwróć ostatni
```

## Słownik

```python
# Tworzenie
osoba = {
    "imie": "Alicja",
    "wiek": 30,
    "miasto": "Warszawa"
}

# Dostęp
osoba["imie"]      # "Alicja"
osoba.get("email", "brak")  # Z domyślną wartością

# Modyfikacja
osoba["email"] = "alicja@przyklad.com"
osoba.update({"telefon": "123-456-7890"})

# Iteracja
for klucz, wartosc in osoba.items():
    print(f"{klucz}: {wartosc}")
```

## Krotka

```python
# Niezmienna sekwencja
wspolrzedne = (10, 20)
punkt = (x, y, z)

# Destrukturyzacja
x, y = wspolrzedne
```

## Zbiór

```python
# Unikalne elementy
kolory = {"czerwony", "zielony", "niebieski"}

# Operacje
kolory.add("żółty")           # Dodaj
kolory.remove("czerwony")     # Usuń (błąd jeśli brak)
kolory.discard("czerwony")     # Usuń (bez błędu)

# Teoria zbiorów
a = {1, 2, 3}
b = {2, 3, 4}
a | b  # Suma {1, 2, 3, 4}
a & b  # Iloczyn {2, 3}
a - b  # Różnica {1}
```

## Powiązane

- [[03-Functions_PL]] - Poprzednie: Funkcje
- [[05-Control-Flow_PL]] - Następne: Sterowanie przepływem
- [[06-OOP_PL]] - Klasy

## Następne kroki

Przejdź do [[05-Control-Flow_PL]] aby dowiedzieć się o sterowaniu przepływem.
