# Objects

Creating and working with objects in JavaScript.

## Object Literals

```javascript
const user = {
  name: "Alice",
  age: 30,
  "special-key": "value",  // Quoted key for special chars
  
  // Method
  greet() {
    return "Hello, I'm " + this.name;
  },
  
  // Computed property
  ["computed" + "Key"]: "value"
};
```

## Accessing Properties

```javascript
// Dot notation
console.log(user.name);

// Bracket notation
console.log(user["age"]);

// Dynamic access
const key = "name";
console.log(user[key]);
```

## Adding/Modifying Properties

```javascript
// Add
user.email = "alice@example.com";
user["phone"] = "123-456-7890";

// Modify
user.age = 31;
```

## this Keyword

```javascript
const user = {
  name: "Alice",
  
  greet() {
    return "Hello, " + this.name;  // 'this' refers to user
  }
};

const greetFn = user.greet;
greetFn();  // 'this' is undefined (strict mode) or window
user.greet();  // 'this' is user
```

## Object Methods

| Method | Description |
|--------|-------------|
| `Object.keys(obj)` | Get array of keys |
| `Object.values(obj)` | Get array of values |
| `Object.entries(obj)` | Get array of [key, value] pairs |
| `Object.assign(target, ...sources)` | Copy/merge objects |
| `Object.freeze(obj)` | Make object immutable |

## Related

- [[03-Functions]] - Previous: Functions
- [[05-Arrays]] - Next: Arrays
- [[06-OOP]] in [[Python-Concepts]] - OOP concepts

## Next Steps

Proceed to [[05-Arrays]] to learn about arrays.
