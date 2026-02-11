# Funkcje

Deklarowanie i używanie funkcji w JavaScript.

## Deklaracja funkcji

```javascript
// Nazwana funkcja
function pozdrawiam(imie) {
  return "Cześć, " + imie + "!";
}
```

## Wyrażenie funkcyjne

```javascript
// Anonimowa funkcja przypisana do zmiennej
const pozdrawiam = function(imie) {
  return "Cześć, " + imie + "!";
};
```

## Funkcje strzałkowe (ES6+)

```javascript
// Zwięzła składnia
const pozdrawiam = (imie) => "Cześć, " + imie + "!";

// Jeden parametr, jedno wyrażenie
const kwadrat = x => x * x;

// Wiele parametrów
const dodaj = (a, b) => a + b;

// Brak parametrów
const losowe = () => Math.random();
```

## Parametry i argumenty

```javascript
// Parametry domyślne
function pozdrawiam(imie = "Gość") {
  return "Cześć, " + imie;
}

// Parametry rest
function suma(...liczby) {
  return liczby.reduce((a, b) => a + b, 0);
}

// Destrukturyzacja parametrów
function wyswietlUzytkownika({ imie, wiek }) {
  console.log(imie + " ma " + wiek + " lat");
}
```

## Wartości zwracane

```javascript
// Jawne zwracanie
function dodaj(a, b) {
  return a + b;
}

// Niejawne zwracanie (funkcje strzałkowe)
const dodaj = (a, b) => a + b;
```

## Powiązane

- [[02-Variables-Constants_PL]] - Poprzednie: Zmienne
- [[04-Objects_PL]] - Następne: Obiekty
- [[08-Async-Basics_PL]] - Funkcje asynchroniczne

## Następne kroki

Przejdź do [[04-Objects_PL]] aby dowiedzieć się o obiektach.
