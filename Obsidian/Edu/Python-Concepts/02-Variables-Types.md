# Variables & Types

Understanding Python's dynamic typing and data types.

## Variables

```python
# Assignment
name = "Alice"      # String
age = 30            # Integer
height = 5.9        # Float
is_active = True    # Boolean

# Reassignment (type can change)
age = "thirty"      # Now a string
```

## Data Types

| Type | Description | Example |
|------|-------------|---------|
| `int` | Integer | `42`, `-7`, `0` |
| `float` | Decimal | `3.14`, `-0.5` |
| `str` | String | `"hello"`, `'world'` |
| `bool` | Boolean | `True`, `False` |
| `None` | None/null | `None` |

## Type Conversion

```python
# Explicit conversion
int("42")      # 42
str(42)       # "42"
float("3.14") # 3.14
bool(1)       # True
bool(0)       # False

# User input (returns string)
age = int(input("Enter age: "))
```

## Type Checking

```python
name = "Alice"
type(name)        # <class 'str'>
isinstance(name, str)  # True

# Type hints (Python 3.5+)
def greet(name: str) -> str:
    return f"Hello, {name}"
```

## Related

- [[01-Introduction]] - Previous: Introduction
- [[03-Functions]] - Next: Functions
- [[04-Data-Structures]] - Data Structures

## Next Steps

Proceed to [[03-Functions]] to learn about functions.
