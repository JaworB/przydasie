# Zmienne i stałe

Deklarowanie i używanie zmiennych w JavaScript.

## var (ES5)

```javascript
// Zakres funkcyjny, hoistowanie
var imię = "Alicja";
var imię = "Bartek";  // Ponowna deklaracja dozwolona
```

## let (ES6+)

```javascript
// Zakres blokowy
let licznik = 0;
licznik = 1;  // Ponowne przypisanie dozwolone
// let licznik = 2;  // Błąd: Identyfikator już zadeklarowany
```

## const (ES6+)

```javascript
// Zakres blokowy, niezmienne wiązanie
const PI = 3.14159;
// PI = 3.14;  // Błąd: Przypisanie do stałej zmiennej

// Dla obiektów/tablic, zawartość może się zmieniać
const użytkownik = { imię: "Alicja" };
użytkownik.imię = "Bartek";  // Dozwolone
// użytkownik = { imię: "Karolina" };  // Błąd
```

## Najlepsze praktyki

| Rób | Nie rób |
|-----|---------|
| Używaj `const` domyślnie | Używaj `var` w nowym kodzie |
| Używaj `let` gdy potrzebne przypisanie | Ponownie deklaruj `let`/`const` |
| Używaj opisowych nazw | Używaj pojedynczych liter (oprócz pętli) |

## Przykłady z repozytorium

```javascript
// Z: edu/js_edu/codecademy_notes/
const liczby = [1, 2, 3, 4, 5];
let suma = 0;
for (let i = 0; i < liczby.length; i++) {
  suma += liczby[i];
}
```

## Powiązane

- [[01-Introduction_PL]] - Poprzednie: Wprowadzenie
- [[03-Functions_PL]] - Następne: Funkcje
- [[10-Best-Practices_PL]] - Najlepsze praktyki

## Następne kroki

Przejdź do [[03-Functions_PL]] aby dowiedzieć się o funkcjach.
