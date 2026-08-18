# --- def, wartości domyślne, argumenty nazwane ---

def przywitaj(imie, powitanie="Cześć"):
    return f"{powitanie}, {imie}!"

print(przywitaj("Jawor"))                        # Cześć, Jawor!
print(przywitaj("Jawor", "Hej"))                 # Hej, Jawor!
print(przywitaj(imie="Jawor", powitanie="Yo"))   # argumenty nazwane

# --- type hints (opcjonalne, nie wymuszane przez interpreter) ---
def dodaj(a: int, b: int) -> int:
    return a + b

# --- *args - dowolna liczba argumentów pozycyjnych (trafiają do krotki) ---
def suma(*liczby):
    return sum(liczby)

print(suma(1, 2, 3, 4))   # 10

# --- **kwargs - dowolna liczba argumentów nazwanych (trafiają do słownika) ---
def opis(**dane):
    for klucz, wartosc in dane.items():
        print(f"{klucz}: {wartosc}")

opis(imie="Jawor", wiek=32)
