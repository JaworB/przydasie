# Functions

Declaring and using functions in JavaScript.

## Function Declaration

```javascript
// Named function
function greet(name) {
  return "Hello, " + name + "!";
}
```

## Function Expression

```javascript
// Anonymous function assigned to variable
const greet = function(name) {
  return "Hello, " + name + "!";
};
```

## Arrow Functions (ES6+)

```javascript
// Concise syntax
const greet = (name) => "Hello, " + name + "!";

// Single parameter, single expression
const square = x => x * x;

// Multiple parameters
const add = (a, b) => a + b;

// No parameters
const random = () => Math.random();
```

## Parameters & Arguments

```javascript
// Default parameters
function greet(name = "Guest") {
  return "Hello, " + name;
}

// Rest parameters
function sum(...numbers) {
  return numbers.reduce((a, b) => a + b, 0);
}

// Destructuring parameters
function printUser({ name, age }) {
  console.log(name + " is " + age + " years old");
}
```

## Return Values

```javascript
// Explicit return
function add(a, b) {
  return a + b;
}

// Implicit return (arrow functions)
const add = (a, b) => a + b;
```

## Related

- [[02-Variables-Constants]] - Previous: Variables
- [[04-Objects]] - Next: Objects
- [[08-Async-Basics]] - Async Functions

## Next Steps

Proceed to [[04-Objects]] to learn about objects.
