# Warunki

Kontrolowanie przepływu programu za pomocą warunków.

## Instrukcja if

```javascript
const wiek = 18;

if (wiek >= 18) {
  console.log("Jesteś pełnoletni");
}
```

## if-else

```javascript
const godzina = 14;

if (godzina < 12) {
  console.log("Dzień dobry");
} else {
  console.log("Dzień dobry popołudniu");
}
```

## if-else if-else

```javascript
const godzina = 14;

if (godzina < 12) {
  console.log("Dzień dobry");
} else if (godzina < 18) {
  console.log("Dzień dobry popołudniu");
} else {
  console.log("Dobry wieczór");
}
```

## Operator trójargumentowy

```javascript
const wiek = 18;
const status = wiek >= 18 ? "Pełnoletni" : "Nieletni";

// Zagnieżdżony trójargumentowy (używaj oszczędnie)
const ocena = wynik >= 90 ? "A" : wynik >= 80 ? "B" : "C";
```

## Instrukcja switch

```javascript
const dzien = "Poniedziałek";

switch (dzien) {
  case "Poniedziałek":
    console.log("Początek tygodnia");
    break;
  case "Piątek":
    console.log("Koniec tygodnia pracy");
    break;
  case "Sobota":
  case "Niedziela":
    console.log("Weekend!");
    break;
  default:
    console.log("Zwykły dzień");
}
```

## Operatory porównania

| Operator | Opis |
|----------|------|
| `==` | Równość (konwersja typów) |
| `===` | Ścisła równość (zalecane) |
| `!=` | Nierówność (konwersja typów) |
| `!==` | Ścisła nierówność |
| `>` | Większe niż |
| `<` | Mniejsze niż |
| `>=` | Większe lub równe |
| `<=` | Mniejsze lub równe |

## Operatory logiczne

| Operator | Opis |
|----------|------|
| `&&` | AND |
| `||` | OR |
| `!` | NOT |

## Powiązane

- [[05-Arrays_PL]] - Poprzednie: Tablice
- [[07-Loops_PL]] - Następne: Pętle
- [[09-Logical-Operators]] w [[../Skrypty-Bash/index_PL]] - Operatory w Bash

## Następne kroki

Przejdź do [[07-Loops_PL]] aby dowiedzieć się o pętlach.
