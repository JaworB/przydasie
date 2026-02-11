# Obiekty

Tworzenie i praca z obiektami w JavaScript.

## Literały obiektów

```javascript
const uzytkownik = {
  imie: "Alicja",
  wiek: 30,
  "klucz-specjalny": "wartosc",

  // Metoda
  pozdrawiam() {
    return "Cześć, jestem " + this.imie;
  },

  // Właściwość obliczana
  ["obliczony" + "Klucz"]: "wartosc"
};
```

## Dostęp do właściwości

```javascript
// Notacja kropkowa
console.log(uzytkownik.imie);

// Notacja nawiasowa
console.log(uzytkownik["wiek"]);

// Dynamiczny dostęp
const klucz = "imie";
console.log(uzytkownik[klucz]);
```

## Dodawanie/modyfikowanie właściwości

```javascript
// Dodaj
uzytkownik.email = "alicja@przyklad.com";
uzytkownik["telefon"] = "123-456-7890";

// Modyfikuj
uzytkownik.wiek = 31;
```

## Słowo kluczowe this

```javascript
const uzytkownik = {
  imie: "Alicja",

  pozdrawiam() {
    return "Cześć, " + this.imie;  // 'this' odnosi się do uzytkownik
  }
};

const fnPozdrawiam = uzytkownik.pozdrawiam;
fnPozdrawiam();  // 'this' jest undefined (tryb ścisły) lub window
uzytkownik.pozdrawiam();  // 'this' jest uzytkownik
```

## Metody obiektów

| Metoda | Opis |
|--------|------|
| `Object.keys(obj)` | Pobierz tablicę kluczy |
| `Object.values(obj)` | Pobierz tablicę wartości |
| `Object.entries(obj)` | Pobierz tablicę par [klucz, wartość] |
| `Object.assign(cel, ...zrodla)` | Kopiuj/scal obiekty |
| `Object.freeze(obj)` | Zrób obiekt niezmiennym |

## Powiązane

- [[03-Functions_PL]] - Poprzednie: Funkcje
- [[05-Arrays_PL]] - Następne: Tablice
- [[06-OOP]] w [[../Python-Concepts/index_PL]] - Koncepcje OOP

## Następne kroki

Przejdź do [[05-Arrays_PL]] aby dowiedzieć się o tablicach.
