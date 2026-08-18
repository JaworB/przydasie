class Ksiazka:
    def __init__(self, tytul, autor, rok_wydania):
        self.tytul = tytul
        self.autor = autor
        self.rok_wydania = rok_wydania

    def opis(self):
        return f"{self.tytul} ({self.rok_wydania}) - {self.autor}"

ksiazka_1 = Ksiazka("Wiedźmin", "Andrzej Sapkowski", 1993)
ksiazka_2 = Ksiazka("Tytuł", "Łukasz Orbitowski", 2010)

print(ksiazka_1.opis())
print(ksiazka_2.opis())


class KontoBankowe:
    def __init__(self, saldo=0):
        self.saldo = saldo
    def wplac(self,kwota:int):
        self.saldo = self.saldo + kwota
        return self.saldo
    def wyplac(self,kwota:int):
        if self.saldo >= kwota:
            self.saldo = self.saldo - kwota
            return self.saldo
        else: 
            return "Kwota przewyższa dostępne saldo"

konto_1 = KontoBankowe(2000)
print(konto_1.wplac(200))
print(konto_1.wyplac(2400))     

class Prostokat:
    licznik_prostokatow = 0
    def __init__(self, szerokosc, wysokosc):
        self.szerokosc = szerokosc
        self.wysokosc = wysokosc
        Prostokat.licznik_prostokatow += 1
    def obwod(self):
        return (self.szerokosc * 2) + (self.wysokosc * 2)
    def pole(self):
        return self.wysokosc * self.szerokosc

prostokat_1 = Prostokat(10,10)
prostokat_2 = Prostokat(10,5)
prostokat_3 = Prostokat(2,5)

print(Prostokat.licznik_prostokatow)