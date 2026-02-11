# Moduły

Organizowanie kodu w moduły wielokrotnego użytku.

## Eksportowanie

```javascript
// Nazwane eksporty
export const PI = 3.14159;

export function dodaj(a, b) {
  return a + b;
}

export class Kolo {
  constructor(promień) {
    this.promień = promień;
  }

  pole() {
    return PI * this.promień * this.promień;
  }
}

// Domyślny eksport
export default function mnoz(a, b) {
  return a * b;
}
```

## Importowanie

```javascript
// Nazwane importy
import { dodaj, PI } from "./matematyka.js";
console.log(dodaj(2, 3));  // 5
console.log(PI);  // 3.14159

// Zmień nazwy importów
import { dodaj as suma } from "./matematyka.js";
console.log(suma(2, 3));  // 5

// Import wszystkiego jako przestrzeń nazw
import * as matematyka from "./matematyka.js";
console.log(matematyka.dodaj(2, 3));
console.log(matematyka.PI);

// Domyślny import
import mnoz from "./matematyka.js";
console.log(mnoz(2, 3));  // 6
```

## Łączony import/eksport

```javascript
// matematyka.js
const PI = 3.14159;

function dodaj(a, b) {
  return a + b;
}

export { PI, dodaj };
```

```javascript
// main.js
import { PI, dodaj } from "./matematyka.js";
```

## CommonJS (Node.js)

```javascript
// Eksport
module.exports = {
  dodaj: (a, b) => a + b,
  PI: 3.14159
};

// Import
const { dodaj, PI } = require("./matematyka");
```

## Powiązane

- [[08-Async-Basics_PL]] - Poprzednie: Podstawy asynchroniczności
- [[10-Best-Practices_PL]] - Następne: Najlepsze praktyki
- [[08-Virtual-Environments]] w [[../Python-Concepts/index_PL]] - Moduły Python

## Następne kroki

Przejdź do [[10-Best-Practices_PL]] aby dowiedzieć się o standardach kodowania.
