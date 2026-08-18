imie = "Jawor"
wiek = 32
uczy_python = True
liczba = 10
liczba_s = "10"

print(f"Mam na imię {imie} i mam {wiek} lat. Czy uczę się python'a? {uczy_python}")

suma = liczba + int(liczba_s)
print(suma)

zmienne = [liczba, imie, uczy_python]

for z in zmienne:
    if isinstance(z, (int, float)):
        print(f"{z!r} to liczba")
    else:
        print(f"{z!r} to nie liczba")