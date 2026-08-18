def bezpieczny_int(tekst):
    try:
        return int(tekst)
    except ValueError:
        return None

def podziel(a,b):
    try:
        wynik = a / b 
        return wynik
    except ZeroDivisionError as e:
        return e
    finally:
        print("Próba dzielenia zakończona")

class UjemnyIndeksError(Exception):
    pass

def pobierz_z_listy(lista, indeks):
    try:
        if indeks < 0:
            raise UjemnyIndeksError("Indeks nie może być ujemny")
        return lista[indeks]
    except IndexError as e:
        return e
    except TypeError as e:
        return e
    except UjemnyIndeksError as e:
        return e

zakupy = ["chleb", "mleko", "chleb", "jajka", "mleko", "masło"]
print(pobierz_z_listy(zakupy,"dupa"))
        