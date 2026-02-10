# Arrays

Creating and manipulating arrays in JavaScript.

## Creating Arrays

```javascript
// Array literal
const numbers = [1, 2, 3, 4, 5];

// Array constructor
const fruits = new Array("apple", "banana", "orange");

// Mixed types
const mixed = [1, "two", true, null, { name: "object" }];
```

## Accessing Elements

```javascript
const arr = ["a", "b", "c", "d", "e"];

arr[0];   // "a" (first element)
arr[2];   // "c"
arr[arr.length - 1];  // "e" (last element)
```

## Array Methods

| Method | Description | Example |
|--------|-------------|---------|
| `push()` | Add to end | `arr.push("f")` |
| `pop()` | Remove from end | `arr.pop()` |
| `unshift()` | Add to start | `arr.unshift(0)` |
| `shift()` | Remove from start | `arr.shift()` |
| `concat()` | Merge arrays | `arr1.concat(arr2)` |
| `slice()` | Extract portion | `arr.slice(1, 3)` |
| `splice()` | Add/remove elements | `arr.splice(2, 1, "x")` |
| `indexOf()` | Find index | `arr.indexOf("c")` |
| `includes()` | Check existence | `arr.includes("a")` |

## Iteration Methods

```javascript
const numbers = [1, 2, 3, 4, 5];

// forEach
numbers.forEach(num => console.log(num));

// map (transform)
const doubled = numbers.map(n => n * 2);  // [2, 4, 6, 8, 10]

// filter
const evens = numbers.filter(n => n % 2 === 0);  // [2, 4]

// reduce
const sum = numbers.reduce((acc, n) => acc + n, 0);  // 15

// find
const found = numbers.find(n => n > 3);  // 4

// findIndex
const index = numbers.findIndex(n => n > 3);  // 3

// some (any match)
const hasEven = numbers.some(n => n % 2 === 0);  // true

// every (all match)
const allPositive = numbers.every(n => n > 0);  // true
```

## Related

- [[04-Objects]] - Previous: Objects
- [[06-Conditionals]] - Next: Conditionals
- [[07-Loops]] - Loops

## Next Steps

Proceed to [[06-Conditionals]] to learn about conditionals.
