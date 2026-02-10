# Best Practices

Coding standards and best practices for JavaScript.

## Naming Conventions

| Type | Convention | Example |
|------|------------|---------|
| Variables | camelCase | `userName`, `itemCount` |
| Constants | UPPER_SNAKE_CASE | `MAX_SIZE`, `API_URL` |
| Functions | camelCase (verb first) | `getUser()`, `fetchData()` |
| Classes | PascalCase | `UserAccount`, `DataService` |
| Private | underscore prefix | `_privateMethod()` |

## Code Style

```javascript
// Good
const addNumbers = (a, b) => a + b;

const users = [
  { name: "Alice", age: 30 },
  { name: "Bob", age: 25 }
];

users.forEach(user => {
  console.log(user.name);
});

// Avoid
const a = 1, b = 2, c = 3;  // Multiple declarations

// Good
const a = 1;
const b = 2;
const c = 3;
```

## Best Practices Checklist

- [x] Use `const` by default, `let` when needed
- [x] Use strict equality (`===` not `==`)
- [x] Use template literals for strings
- [x] Use arrow functions for callbacks
- [x] Handle errors with try/catch in async code
- [x] Use descriptive variable names
- [x] Keep functions small and focused
- [x] Comment complex logic (not obvious code)
- [x] Use linter (ESLint)
- [x] Write tests

## Common Patterns

```javascript
// Destructuring
const { name, age } = user;
const [first, second] = array;

// Spread operator
const newArray = [...oldArray, newItem];
const newObject = { ...oldObject, newKey: newValue };

// Ternary for simple conditions
const status = isActive ? "Active" : "Inactive";
```

## Related

- [[09-Modules]] - Previous: Modules
- [[01-Introduction]] - Return to Introduction
- [[Python-Concepts]] - Python best practices

## Return to [[index]]
