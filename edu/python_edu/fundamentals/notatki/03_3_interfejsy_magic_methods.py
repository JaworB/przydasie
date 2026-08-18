# Temat 3.3 - Interfejsy (ABC/Protocol) i magic methods

from abc import ABC, abstractmethod

# ABC - klasa abstrakcyjna, wymusza implementacje w podklasach

class Ksztalt(ABC):
    @abstractmethod
    def pole(self):
        pass

    @abstractmethod
    def obwod(self):
        pass


class Prostokat(Ksztalt):
    def __init__(self, a, b):
        self.a = a
        self.b = b

    def pole(self):
        return self.a * self.b

    def obwod(self):
        return 2 * (self.a + self.b)


# Ksztalt()  # TypeError: nie można stworzyć instancji klasy abstrakcyjnej
p = Prostokat(3, 4)
print(p.pole(), p.obwod())   # 12 14


# Protocol - interfejs "strukturalny" (duck typing), bez wymogu dziedziczenia
# sprawdzany głównie statycznie (np. przez mypy), nie przez sam interpreter

from typing import Protocol, runtime_checkable

@runtime_checkable
class MaPole(Protocol):
    def pole(self) -> float: ...


class Kolo:                 # brak dziedziczenia po MaPole - i tak pasuje
    def __init__(self, r):
        self.r = r
    def pole(self):
        return 3.14 * self.r ** 2


def wypisz_pole(obiekt: MaPole):
    print(obiekt.pole())

wypisz_pole(Prostokat(3, 4))   # 12 - pasuje, bo ma pole()
wypisz_pole(Kolo(5))           # 78.5 - pasuje, bo ma pole()

print(isinstance(Kolo(5), MaPole))   # True, dzięki @runtime_checkable

# Bez pasującej metody Protocol NIC nie chroni w runtime - sam interpreter
# nie sprawdza typu parametru, dopiero brak metody wywoła zwykły
# AttributeError w środku funkcji (nie wcześniej):
#
# class Trojkat:
#     def __init__(self, bok):
#         self.bok = bok
#
# wypisz_pole(Trojkat(5))
# -> AttributeError: 'Trojkat' object has no attribute 'pole'
#
# Narzędzie mypy złapałoby to statycznie, przed uruchomieniem - sam Python
# w locie tego nie robi.

# Różnica ABC vs Protocol:
# - ABC: trzeba jawnie dziedziczyć, sprawdzane przy tworzeniu obiektu
# - Protocol: nie trzeba dziedziczyć, sprawdzane głównie statycznie (mypy),
#   w runtime tylko jeśli @runtime_checkable + jawne isinstance()


# Magic methods (dunder methods) - Python wywołuje je automatycznie
# przy określonych operacjach

class Wektor:
    def __init__(self, x, y):
        self.x = x
        self.y = y

    def __repr__(self):
        return f"Wektor({self.x}, {self.y})"

    def __eq__(self, other):
        return self.x == other.x and self.y == other.y

    def __add__(self, other):
        return Wektor(self.x + other.x, self.y + other.y)

    def __len__(self):
        return int((self.x ** 2 + self.y ** 2) ** 0.5)


v1 = Wektor(1, 2)
v2 = Wektor(3, 4)

print(v1)                    # Wektor(1, 2)          <- __repr__
print(v1 + v2)                # Wektor(4, 6)          <- __add__
print(v1 == Wektor(1, 2))     # True                  <- __eq__
print(len(v2))                # 5                     <- __len__
