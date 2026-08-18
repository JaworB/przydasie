class Pojazd:
    def __init__(self, marka, predkosc_max):
        self.marka = marka
        self.predkosc_max = predkosc_max
    def opis(self):
        return f"{self.marka}, prędkośc maks. {self.predkosc_max}"

class Samochod(Pojazd):
    def __init__(self, marka, predkosc_max, liczba_drzwi):
        super().__init__(marka, predkosc_max)
        self.liczba_drzwi = liczba_drzwi

class Ksztalt:
    def pole(self):
        return 0

class Kwadrat(Ksztalt):
    def __init__(self,bok):
        super().__init__()
        self.bok = bok
    def pole(self):
        return self.bok ** 2

class Koło(Ksztalt):
    def __init__(self, promien):
        super().__init__()
        self.promien = promien
    def pole(self):
        return 3.14 * self.promien ** 2

kształty = [Koło(5), Kwadrat(3)]
for k in kształty:
    print(k.pole())

class Konto:
    def __init__(self, saldo=0):
        self.saldo = saldo
    def wplac(self, kwota):
        self.saldo = self.saldo + kwota

class KontoOszczędościowe(Konto):
    def __init__(self, oprocentowanie, saldo=0):
        super().__init__(saldo)
        self.oprocentowanie = oprocentowanie
    def dolicz_odsetki(self):
        odsetki = self.saldo * self.oprocentowanie
        self.saldo = self.saldo + odsetki

k = KontoOszczędościowe(0.8,2000)

print(isinstance(k, KontoOszczędościowe))
print(isinstance(k, Konto))