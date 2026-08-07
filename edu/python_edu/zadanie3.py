def czyParzysta(liczba: int) -> bool:
    return liczba % 2 == 0

print(czyParzysta(3))

def fizzbuzz(i):
    if ( i % 3 == 0 and i % 5 == 0 ):
        return (f"{i}: FizzBuzz")
    elif i % 5 == 0:
        return (f"{i}: Buzz")
    elif i % 3 == 0:
        return (f"{i}: Fizz")
    else:
        return i

for i in range(1, 21): print(fizzbuzz(i))

def statystkyki(*liczby):
    avg = sum(liczby) / len(liczby)
    return (min(liczby), max(liczby), sum(liczby),avg)

print(statystkyki(1, 2, 3, 4)) 