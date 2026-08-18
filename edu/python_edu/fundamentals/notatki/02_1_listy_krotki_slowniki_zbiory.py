# --- list - uprzorządkowana , Mutowalna

lista = ["jabłko", "gruszka", "banan"]

lista.append("śliwka")              #dodaje na koniec
lista.insert(0, "wiśnia")           #dodaje w określonej pozycji
ostatni = lista.pop()               #usuwa i ZWRACA ostatni element (albo wskazany jeśli lista.pop(indeks))
lista[1] = "arbuz"                  #nadpisanie elementu

print(lista)        
print(len(lista))                   #długość listy
print("jabłko" in lista)            #sprawdzaniem czy element istnieje w liscie -> True 

# --- tuple - jak lista, ale NIEMUTOWALNA

wspolrzedne = (10,55,12.0)
#wspolrzedne[1] = 80 -> wywali błąd


# --- dict - klucz -> wartość

osoba = {"imie": "Jawor", "wiek": 32}
osoba["miasto"] = "Jelenia Góra"     # dopisanie/nadpisanie klucza
del osoba["wiek"]                    # usunięcie klucza
print(osoba.get("imie"))             # bezpieczny odczyt (None zamiast błędu, gdy brak kluc
print("miasto" in osoba)             # sprawdzenie czy klucz istnieje -> True

for klucz, wartosc in osoba.items():
    print(f"{klucz}: {wartosc}")

# --- set - unikalne, nieuprządkowane ---
zbior = {1,2,2,3}                       # duplikaty znikają automatycznie -> {1, 2, 3}
zbior.add(4)
zbior.discard(2)
print(3 in zbior)