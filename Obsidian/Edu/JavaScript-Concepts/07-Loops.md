# Loops

Repeating code with loops in JavaScript.

## for Loop

```javascript
// Traditional for loop
for (let i = 0; i < 5; i++) {
  console.log(i);  // 0, 1, 2, 3, 4
}

// Loop through array
const fruits = ["apple", "banana", "orange"];
for (let i = 0; i < fruits.length; i++) {
  console.log(fruits[i]);
}
```

## while Loop

```javascript
let count = 0;

while (count < 5) {
  console.log(count);
  count++;
}
```

## do-while Loop

```javascript
let num = 0;

do {
  console.log(num);
  num++;
} while (num < 5);
```

## for...of Loop (ES6+)

```javascript
const fruits = ["apple", "banana", "orange"];

for (const fruit of fruits) {
  console.log(fruit);  // Each element
}
```

## for...in Loop

```javascript
const user = { name: "Alice", age: 30, city: "NYC" };

for (const key in user) {
  console.log(key + ": " + user[key]);  // Each property
}
```

## forEach Loop

```javascript
const numbers = [1, 2, 3, 4, 5];

numbers.forEach((element, index, array) => {
  console.log(`Element: ${element}, Index: ${index}`);
});
```

## Loop Control

```javascript
// break - exit loop
for (let i = 0; i < 10; i++) {
  if (i === 5) break;
  console.log(i);  // 0, 1, 2, 3, 4
}

// continue - skip iteration
for (let i = 0; i < 5; i++) {
  if (i === 2) continue;
  console.log(i);  // 0, 1, 3, 4
}
```

## Related

- [[06-Conditionals]] - Previous: Conditionals
- [[07-Control-Flow]] in [[Bash-Scripting-Concepts]] - Bash control flow
- [[05-Arrays]] - Arrays with forEach

## Next Steps

Proceed to [[08-Async-Basics]] to learn about asynchronous JavaScript.
