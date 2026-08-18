liczby = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
podzielne = [n for n in liczby if n % 3 == 0]

slowa = ["kot", "pies", "słoń", "mysz", "żyrafa"]
slownik = {n: len(n) for n in slowa}

zakupy = ["chleb", "mleko", "chleb", "jajka", "mleko", "masło"]
unikalne = {item for item in zakupy}
lista = {item: zakupy.count(item) for item in unikalne}
print(podzielne)
print(lista)
print(slownik)