try:
    liczba = int("abc")     # to rzuci błąd - "abc" nie da się skonwertować
except ValueError:
    print("To nie jest liczba!")

# łapanie konkretnego typu błędu i dostęp do komunikatu:
try:
    wynik = 10 / 0
except ZeroDivisionError as e:
    print(f"Błąd: {e}")

# kilka typów błędów naraz:
try:
    dane = {"a": 1}
    print(dane["b"])
except (KeyError, TypeError) as e:
    print(f"Coś poszło nie tak: {e}")

# else - wykonuje się TYLKO gdy nie było wyjątku
# finally - wykonuje się ZAWSZE, niezależnie od wyniku
try:
    x = int("42")
except ValueError:
    print("błąd konwersji")
else:
    print(f"udało się: {x}")
finally:
    print("koniec próby")

# rzucanie własnego wyjątku:
def sprawdz_wiek(wiek):
    if wiek < 0:
        raise ValueError("wiek nie może być ujemny")
    return wiek