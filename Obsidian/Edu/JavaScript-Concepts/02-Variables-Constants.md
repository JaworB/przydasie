# Variables & Constants

Declaring and using variables in JavaScript.

## var (ES5)

```javascript
// Function-scoped, hoisted
var name = "Alice";
var name = "Bob";  // Redeclare allowed
```

## let (ES6+)

```javascript
// Block-scoped
let count = 0;
count = 1;  // Reassign allowed
// let count = 2;  // Error: Identifier already declared
```

## const (ES6+)

```javascript
// Block-scoped, immutable binding
const PI = 3.14159;
// PI = 3.14;  // Error: Assignment to constant variable

// For objects/arrays, content can change
const user = { name: "Alice" };
user.name = "Bob";  // Allowed
// user = { name: "Carol" };  // Error
```

## Best Practices

| Do | Don't |
|-----|-------|
| Use `const` by default | Use `var` in new code |
| Use `let` when reassignment needed | Redeclare `let`/`const` |
| Use descriptive names | Use single letters (except loops) |

## Examples from Repository

```javascript
// From: edu/js_edu/codecademy_notes/
const numbers = [1, 2, 3, 4, 5];
let sum = 0;
for (let i = 0; i < numbers.length; i++) {
  sum += numbers[i];
}
```

## Related

- [[01-Introduction]] - Previous: Introduction
- [[03-Functions]] - Next: Functions
- [[10-Best-Practices]] - Best Practices

## Next Steps

Proceed to [[03-Functions]] to learn about functions.
