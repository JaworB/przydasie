from abc import ABC, abstractmethod
class Pracownik(ABC):
    @abstractmethod
    def wynagrodzenie(self):
        pass

class PracownikEtatowy(Pracownik):
    def __init__(self, stała_pensja):
        super().__init__()
        self.stała_pensja = stała_pensja
    def wynagrodzenie(self):
        return self.stała_pensja

class Zleceniobiorca(Pracownik):
    def __init__(self, stawka_godzinowa, liczba_godzin):
        super().__init__()
        self.stawka_godzinowa = stawka_godzinowa
        self.liczba_godzin = liczba_godzin
    def wynagrodzenie(self):
        return self.stawka_godzinowa * self.liczba_godzin

from typing import Protocol, runtime_checkable
@runtime_checkable
class MaDzwiek(Protocol):
    def dzwiek(self) -> str: ...

def odtworz(obiekt: MaDzwiek):
    print(obiekt.dzwiek())

class Dzwiek_1():
    def dzwiek(self):
        return f"Dzwiek_1 - wynik"

class Dzwiek_2():
    def dzwiek(self):
       return f"Dzwiek_2 - wynik"

class Punkt():
    def __init__(self, x ,y):
        self.x = x
        self.y = y
    def __eq__(self, other):
        return self.x == other.x and self.y == other.y
    def __repr__(self):
        return f"Punkt ({self.x}, {self.y})"
    def __add__(self, other):
        return Punkt(self.x + other.x , self.y + other.y)

p1 = Punkt(1, 2)
p2 = Punkt(1, 2)

print(p1)
print(p1 + p2)
print(p1 == Punkt(1, 2))

odtworz(Dzwiek_1())
odtworz(Dzwiek_2())
