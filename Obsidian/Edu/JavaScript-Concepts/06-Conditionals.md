# Conditionals

Controlling program flow with conditions.

## if Statement

```javascript
const age = 18;

if (age >= 18) {
  console.log("You are an adult");
}
```

## if-else

```javascript
const hour = 14;

if (hour < 12) {
  console.log("Good morning");
} else {
  console.log("Good afternoon");
}
```

## if-else if-else

```javascript
const hour = 14;

if (hour < 12) {
  console.log("Good morning");
} else if (hour < 18) {
  console.log("Good afternoon");
} else {
  console.log("Good evening");
}
```

## Ternary Operator

```javascript
const age = 18;
const status = age >= 18 ? "Adult" : "Minor";

// Nested ternary (use sparingly)
const grade = score >= 90 ? "A" : score >= 80 ? "B" : "C";
```

## switch Statement

```javascript
const day = "Monday";

switch (day) {
  case "Monday":
    console.log("Start of the week");
    break;
  case "Friday":
    console.log("End of the work week");
    break;
  case "Saturday":
  case "Sunday":
    console.log("Weekend!");
    break;
  default:
    console.log("Regular day");
}
```

## Comparison Operators

| Operator | Description |
|----------|-------------|
| `==` | Equality (type coercion) |
| `===` | Strict equality (recommended) |
| `!=` | Inequality (type coercion) |
| `!==` | Strict inequality |
| `>` | Greater than |
| `<` | Less than |
| `>=` | Greater than or equal |
| `<=` | Less than or equal |

## Logical Operators

| Operator | Description |
|----------|-------------|
| `&&` | AND |
| `||` | OR |
| `!` | NOT |

## Related

- [[05-Arrays]] - Previous: Arrays
- [[07-Loops]] - Next: Loops
- [[09-Logical-Operators]] in [[Bash-Scripting-Concepts]] - Bash operators

## Next Steps

Proceed to [[07-Loops]] to learn about loops.
