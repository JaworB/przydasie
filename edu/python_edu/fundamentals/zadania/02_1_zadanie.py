pierwsza = ["Wiedźmin", "Solaris", "1866" ]
pierwsza.append("Niezwyciężony")
pierwsza.remove("Wiedźmin")
print(f"{pierwsza}, długosć {len(pierwsza)}")


slownik = {"nazwa": "Wiedźmin", "cena": 4.9, "ilość": 1}
def kwota(cena, ilosc):
    return cena * ilosc
print(kwota(slownik["cena"], slownik["ilość"]))
print("rabat" in slownik)


zakupy = ["chleb", "mleko", "chleb", "jajka", "mleko", "masło"]

unikalne = set(zakupy)
print (unikalne)

licznik = {}
for item in zakupy:
    aktualna_wartość = licznik.get(item, 0)
    licznik[item] = aktualna_wartość +1

print(licznik)

najczesciej = None
najwiecej = 0

for item, ilosc in licznik.items():
    if ilosc > najwiecej:
        najwiecej = ilosc
        najczesciej = item
print(f"Najczęstsze: {najczesciej} (ilosc {najwiecej})")



slowa = ["kot", "pies", "kot", "papuga", "pies", "kot"]
unikalne = set(slowa)
print(unikalne)

licznik = {}
for zwierze in slowa:
    value = licznik.get(zwierze, 0)
    licznik[zwierze] = value +1
print(licznik)

najczesciej = None
najwiecej = 0
for zwierze, ile in licznik.items():
    if ile > najwiecej:
        najwiecej = ile
        najczesciej = zwierze
print(f"Najczęstsze: {najczesciej} ({najwiecej} razy)")