for i in range(1,21):
    if ( i % 3 == 0 and i % 5 == 0 ):
        print(f"{i}: FizzBuzz")
    elif i % 5 == 0:
        print(f"{i}: Buzz")
    elif i % 3 == 0:
        print(f"{i}: Fizz")

lista = [3, -1, 7, 0, -5, 12, 8]
suma_dodatnich = 0
suma_ujemnych = 0

for liczba in lista:
    if liczba > 0:
        suma_dodatnich += liczba
    elif liczba < 0:
        suma_ujemnych += liczba

login_tries = [False, False, False, True]
login_attempt = 0

while login_attempt < 3:
    proba = login_tries[login_attempt]
    print(proba)
    if proba == True:
        print("Zalogowano")
        break
    elif proba == False:
        print("Błąd" )
        login_attempt += 1
        if login_attempt == 3:
            print("Konto zablokowane")