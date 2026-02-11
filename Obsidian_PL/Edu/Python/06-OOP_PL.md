# Programowanie obiektowe

Klasy i dziedziczenie w Pythonie.

## Klasa

```python
class Pies:
    # Konstruktor
    def __init__(self, imie, rasa):
        self.imie = imie
        self.rasa = rasa
    
    # Metoda
    def szczekaj(self):
        return f"{self.imie} szczeka!"

# Tworzenie obiektu
pies = Pies("Burek", "Labrador")
print(pies.szczekaj())  # "Burek szczeka!"
```

## Dziedziczenie

```python
class Zwierze:
    def __init__(self, imie):
        self.imie = imie
    
    def daj_glos(self):
        pass

class Kot(Zwierze):
    def daj_glos(self):
        return f"{self.imie} miau!"

class Pies(Zwierze):
    def daj_glos(self):
        return f"{self.imie} szczeka!"

# Polimorfizm
zwierzeta = [Kot("Mruczek"), Pies("Burek")]
for z in zwierzeta:
    print(z.daj_glos())
```

## Metody specjalne

```python
class Osoba:
    def __init__(self, imie, wiek):
        self.imie = imie
        self.wiek = wiek
    
    def __str__(self):
        return f"{self.imie}, {self.wiek} lat"
    
    def __eq__(self, other):
        return self.wiek == other.wiek
```

## Dziedziczenie wielokrotne

```class A: pass
class B: pass
class C(A, B): pass  # Dziedziczy z A i B
```

## Powiązane

- [[05-Control-Flow_PL]] - Poprzednie: Sterowanie przepływem
- [[07-Files-IO_PL]] - Następne: Pliki I/O
- [[04-Objects_PL]] w [[../JavaScript/index_PL]] - Obiekty w JavaScript

## Następne kroki

Przejdź do [[07-Files-IO_PL]] aby dowiedzieć się o operacjach na plikach.
