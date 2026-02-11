# Sterowanie przepływem

Instrukcje warunkowe i pętle w Pythonie.

## Instrukcje warunkowe

```python
wiek = 18

if wiek >= 18:
    print("Pełnoletni")
elif wiek >= 13:
    print("Nastolatek")
else:
    print("Dziecko")
```

## Operatory porównania

| Operator | Opis |
|----------|------|
| `==` | Równe |
| `!=` | Różne |
| `>` | Większe |
| `<` | Mniejsze |
| `>=` | Większe lub równe |
| `<=` | Mniejsze lub równe |

## Operatory logiczne

| Operator | Opis |
|----------|------|
| `and` | Oba muszą być True |
| `or` | Co najmniej jeden True |
| `not` | Negacja |

## Pętla for

```python
# Iteracja po sekwencji
for i in range(5):
    print(i)  # 0, 1, 2, 3, 4

for owoc in ["jablko", "banan", "pomarańcza"]:
    print(owoc)

for klucz, wartosc in slownik.items():
    print(klucz, wartosc)
```

## Pętla while

```python
licznik = 0
while licznik < 5:
    print(licznik)
    licznik += 1
```

## break i continue

```python
for i in range(10):
    if i == 5:
        break   # Wyjdź z pętli
    if i % 2 == 0:
        continue  # Pomiń iterację
    print(i)  # 1, 3, 7, 9
```

## List comprehension

```python
# Podstawowy
kwadraty = [x**2 for x in range(10)]

# Z warunkiem
parzyste_kwadraty = [x**2 for x in range(10) if x % 2 == 0]

# Słownik comprehension
{x: x**2 for x in range(5)}
```

## Powiązane

- [[04-Data-Structures_PL]] - Poprzednie: Struktury danych
- [[06-OOP_PL]] - Następne: Programowanie obiektowe
- [[05-Control-Flow]] w [[../Skrypty-Bash/index_PL]] - Sterowanie przepływem w Bash

## Następne kroki

Przejdź do [[06-OOP_PL]] aby dowiedzieć się o programowaniu obiektowym.
