# Modules

Organizing code into reusable modules.

## Exporting

```javascript
// Named exports
export const PI = 3.14159;

export function add(a, b) {
  return a + b;
}

export class Circle {
  constructor(radius) {
    this.radius = radius;
  }
  
  area() {
    return PI * this.radius * this.radius;
  }
}

// Default export
export default function multiply(a, b) {
  return a * b;
}
```

## Importing

```javascript
// Named imports
import { add, PI } from "./math.js";
console.log(add(2, 3));  // 5
console.log(PI);  // 3.14159

// Rename imports
import { add as sum } from "./math.js";
console.log(sum(2, 3));  // 5

// Import all as namespace
import * as math from "./math.js";
console.log(math.add(2, 3));
console.log(math.PI);

// Default import
import multiply from "./math.js";
console.log(multiply(2, 3));  // 6
```

## Combined Import/Export

```javascript
// math.js
const PI = 3.14159;

function add(a, b) {
  return a + b;
}

export { PI, add };
```

```javascript
// main.js
import { PI, add } from "./math.js";
```

## CommonJS (Node.js)

```javascript
// Export
module.exports = {
  add: (a, b) => a + b,
  PI: 3.14159
};

// Import
const { add, PI } = require("./math");
```

## Related

- [[08-Async-Basics]] - Previous: Async Basics
- [[10-Best-Practices]] - Next: Best Practices
- [[08-Virtual-Environments]] in [[Python-Concepts]] - Python modules

## Next Steps

Proceed to [[10-Best-Practices]] to learn about coding standards.
