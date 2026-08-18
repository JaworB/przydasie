class Zwierze:
    def __init__(self, imie, wiek):     # konstruktor - wywoływany przy tworzeniu obiektu
        self.imie = imie                 # atrybut obiektu
        self.wiek = wiek

    def przedstaw_sie(self):             # metoda - self zawsze jako pierwszy parametr
        return f"Jestem {self.imie}, mam {self.wiek} lat"

zwierze = Zwierze("Reksio", 3)           # tworzenie obiektu
print(zwierze.przedstaw_sie())            # Jestem Reksio, mam 3 lat
print(zwierze.imie)                       # bezpośredni dostęp do atrybutu

zwierze.wiek = 4                          # atrybuty można zmieniać po utworzeniu
print(zwierze.wiek)                       # 4

# atrybut klasy - wspólny dla wszystkich instancji, nie tylko jednego obiektu
class Licznik:
    ilosc_instancji = 0                   # atrybut KLASY, zdefiniowany raz, poza __init__

    def __init__(self):
        Licznik.ilosc_instancji += 1      # dostęp przez nazwę klasy, nie self

a = Licznik()
b = Licznik()
print(Licznik.ilosc_instancji)            # 2

########################################################

class Zwierze:
    def __init__(self, imie):
        self.imie = imie

    def przedstaw_sie(self):
        return f"Jestem {self.imie}"

reksio = Zwierze("Reksio")

print(reksio.przedstaw_sie())          # normalny sposób
print(Zwierze.przedstaw_sie(reksio))   # to samo, ale jawnie widać przekazanie obiektu