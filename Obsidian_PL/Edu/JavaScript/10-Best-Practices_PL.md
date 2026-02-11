# Najlepsze praktyki

Standardy kodowania i najlepsze praktyki dla JavaScript.

## Konwencje nazewnictwa

| Typ | Konwencja | Przykład |
|-----|------------|---------|
| Zmienne | camelCase | `nazwaUzytkownika`, `licznikElementow` |
| Stałe | UPPER_SNAKE_CASE | `MAX_ROZMIAR`, `API_URL` |
| Funkcje | camelCase (czasownik pierwszy) | `pobierzUzytkownika()`, `pobierzDane()` |
| Klasy | PascalCase | `KontoUzytkownika`, `SerwisDanych` |
| Prywatne | prefiks podkreślenia | `_prywatnaMetoda()` |

## Styl kodu

```javascript
// Dobrze
const dodajLiczby = (a, b) => a + b;

const uzytkownicy = [
  { imie: "Alicja", wiek: 30 },
  { imie: "Bartek", wiek: 25 }
];

uzytkownicy.forEach(uzytkownik => {
  console.log(uzytkownik.imie);
});

// Unikaj
const a = 1, b = 2, c = 3;  // Wiele deklaracji

// Dobrze
const a = 1;
const b = 2;
const c = 3;
```

## Lista kontrolna najlepszych praktyk

- [x] Używaj `const` domyślnie, `let` gdy potrzebne
- [x] Używaj ścisłej równości (`===` nie `==`)
- [x] Używaj literałów szablonowych dla ciągów
- [x] Używaj funkcji strzałkowych dla callbacków
- [x] Obsługuj błędy z try/catch w kodzie async
- [x] Używaj opisowych nazw zmiennych
- [x] Zachowuj małe i skupione funkcje
- [x] Komentuj złożoną logikę (nie oczywisty kod)
- [x] Używaj lintera (ESLint)
- [x] Pisz testy

## Popularne wzorce

```javascript
// Destrukturyzacja
const { imie, wiek } = uzytkownik;
const [pierwszy, drugi] = tablica;

// Operator rozproszenia
const nowaTablica = [...staraTablica, nowyElement];
const nowyObiekt = { ...staryObiekt, nowyKlucz: nowaWartosc };

// Trójargumentowy dla prostych warunków
const status = czyAktywny ? "Aktywny" : "Nieaktywny";
```

## Powiązane

- [[09-Modules_PL]] - Poprzednie: Moduły
- [[01-Introduction_PL]] - Wróć do wprowadzenia
- [[../Python-Concepts/index_PL]] - Najlepsze praktyki Python

## Wróć do [[index_PL]]
