# Temat 3.2 - Dziedziczenie i polimorfizm

class Zwierze:
    def __init__(self, imie):
        self.imie = imie

    def wydaj_dzwiek(self):
        return "Jakiś dźwięk"

    def przedstaw_sie(self):
        return f"{self.imie} mówi: {self.wydaj_dzwiek()}"


class Pies(Zwierze):
    def wydaj_dzwiek(self):
        return "Hau!"


class Kot(Zwierze):
    def wydaj_dzwiek(self):
        return "Miau!"


reksio = Pies("Reksio")
mruczek = Kot("Mruczek")

print(reksio.przedstaw_sie())    # Reksio mówi: Hau!
print(mruczek.przedstaw_sie())   # Mruczek mówi: Miau!


# super() - rozszerzenie konstruktora rodzica zamiast całkowitego nadpisania

class Pracownik:
    def __init__(self, imie, pensja):
        self.imie = imie
        self.pensja = pensja


class Kierownik(Pracownik):
    def __init__(self, imie, pensja, zespol):
        super().__init__(imie, pensja)
        self.zespol = zespol


k = Kierownik("Anna", 9000, ["Piotr", "Kasia"])
print(k.imie, k.pensja, k.zespol)


# polimorfizm - ta sama metoda, różne zachowanie zależnie od klasy obiektu

zwierzeta = [Pies("Reksio"), Kot("Mruczek"), Zwierze("Coś")]

for z in zwierzeta:
    print(z.przedstaw_sie())


# isinstance() - sprawdzenie typu obiektu (uwzględnia dziedziczenie)

print(isinstance(reksio, Pies))     # True
print(isinstance(reksio, Zwierze))  # True - Pies jest też Zwierze
print(isinstance(reksio, Kot))      # False
