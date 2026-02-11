# Pętle

Powtarzanie kodu za pomocą pętli w JavaScript.

## Pętla for

```javascript
// Tradycyjna pętla for
for (let i = 0; i < 5; i++) {
  console.log(i);  // 0, 1, 2, 3, 4
}

// Iteracja po tablicy
const owoce = ["jablko", "banan", "pomarańcza"];
for (let i = 0; i < owoce.length; i++) {
  console.log(owoce[i]);
}
```

## Pętla while

```javascript
let licznik = 0;

while (licznik < 5) {
  console.log(licznik);
  licznik++;
}
```

## Pętla do-while

```javascript
let liczba = 0;

do {
  console.log(liczba);
  liczba++;
} while (liczba < 5);
```

## Pętla for...of (ES6+)

```javascript
const owoce = ["jablko", "banan", "pomarańcza"];

for (const owoc of owoce) {
  console.log(owoc);  // Każdy element
}
```

## Pętla for...in

```javascript
const uzytkownik = { imie: "Alicja", wiek: 30, miasto: "Warszawa" };

for (const klucz in uzytkownik) {
  console.log(klucz + ": " + uzytkownik[klucz]);  // Każda właściwość
}
```

## Pętla forEach

```javascript
const liczby = [1, 2, 3, 4, 5];

liczby.forEach((element, indeks, tablica) => {
  console.log(`Element: ${element}, Indeks: ${indeks}`);
});
```

## Kontrola pętli

```javascript
// break - wyjdź z pętli
for (let i = 0; i < 10; i++) {
  if (i === 5) break;
  console.log(i);  // 0, 1, 2, 3, 4
}

// continue - pomiń iterację
for (let i = 0; i < 5; i++) {
  if (i === 2) continue;
  console.log(i);  // 0, 1, 3, 4
}
```

## Powiązane

- [[06-Conditionals_PL]] - Poprzednie: Warunki
- [[05-Control-Flow]] w [[../Skrypty-Bash/index_PL]] - Sterowanie przepływem w Bash
- [[05-Arrays_PL]] - Tablice z forEach

## Następne kroki

Przejdź do [[08-Async-Basics_PL]] aby dowiedzieć się o asynchronicznym JavaScript.
