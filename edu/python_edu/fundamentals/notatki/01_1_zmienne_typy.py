# --- zmienne i typy - bez deklaracji typu, bez $ jak w PHP ---

imie = "Jawor"
wiek = 30
pi = 3.14
lubi_php = True
brak_wartosci = None

print(type(imie))   # <class 'str'>
print(type(wiek))   # <class 'int'>
print(f"Mam na imię {imie} i mam {wiek} lat")

# Python jest silniej typowany niż PHP - nie skonwertuje po cichu
# "5" + 5 -> TypeError, trzeba jawnie int()/str()
