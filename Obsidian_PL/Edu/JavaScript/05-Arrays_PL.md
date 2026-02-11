# Tablice

Tworzenie i manipulowanie tablicami w JavaScript.

## Tworzenie tablic

```javascript
// Literał tablicy
const liczby = [1, 2, 3, 4, 5];

// Konstruktor tablicy
const owoce = new Array("jablko", "banan", "pomarańcza");

// Mieszane typy
const mieszane = [1, "dwa", true, null, { imie: "obiekt" }];
```

## Dostęp do elementów

```javascript
const arr = ["a", "b", "c", "d", "e"];

arr[0];   // "a" (pierwszy element)
arr[2];   // "c"
arr[arr.length - 1];  // "e" (ostatni element)
```

## Metody tablic

| Metoda | Opis | Przykład |
|--------|------|----------|
| `push()` | Dodaj na koniec | `arr.push("f")` |
| `pop()` | Usuń z końca | `arr.pop()` |
| `unshift()` | Dodaj na początek | `arr.unshift(0)` |
| `shift()` | Usuń z początku | `arr.shift()` |
| `concat()` | Scal tablice | `arr1.concat(arr2)` |
| `slice()` | Wyodrębnij część | `arr.slice(1, 3)` |
| `splice()` | Dodaj/usuń elementy | `arr.splice(2, 1, "x")` |
| `indexOf()` | Znajdź indeks | `arr.indexOf("c")` |
| `includes()` | Sprawdź istnienie | `arr.includes("a")` |

## Metody iteracji

```javascript
const liczby = [1, 2, 3, 4, 5];

// forEach
liczby.forEach(num => console.log(num));

// map (transformuj)
const podwojone = liczby.map(n => n * 2);  // [2, 4, 6, 8, 10]

// filter
const parzyste = liczby.filter(n => n % 2 === 0);  // [2, 4]

// reduce
const suma = liczby.reduce((acc, n) => acc + n, 0);  // 15

// find
const znaleziony = liczby.find(n => n > 3);  // 4

// findIndex
const indeks = liczby.findIndex(n => n > 3);  // 3

// some (jakiekolwiek dopasowanie)
const maParzyste = liczby.some(n => n % 2 === 0);  // true

// every (wszystkie dopasowanie)
const wszystkieDodatnie = liczby.every(n => n > 0);  // true
```

## Powiązane

- [[04-Objects_PL]] - Poprzednie: Obiekty
- [[06-Conditionals_PL]] - Następne: Warunki
- [[07-Loops_PL]] - Pętle

## Następne kroki

Przejdź do [[06-Conditionals_PL]] aby dowiedzieć się o warunkach.
