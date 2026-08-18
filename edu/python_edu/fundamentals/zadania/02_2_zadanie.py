a = " Python jest Fajny "
print(a.strip().lower())

b = "Ala ma kota"
print(len(b.split(" ")))
print("-".join(b.split(" ")))

test = "Kobyła ma mały bok"
def czy_palindrom(tekst):
    normalize = tekst.replace(" ", "").lower()
    revert = normalize[::-1]
    if normalize == revert:
        return True
    else:
        return False

czy_palindrom(test)