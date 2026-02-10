# Best Practices

PEP 8 guidelines and coding standards for Python.

## Naming Conventions

| Type | Convention | Example |
|------|-------------|---------|
| Variables | snake_case | `user_name`, `item_count` |
| Constants | UPPER_SNAKE_CASE | `MAX_SIZE`, `API_URL` |
| Functions | snake_case | `get_user()`, `fetch_data()` |
| Classes | PascalCase | `UserAccount`, `DataService` |
| Modules | snake_case | `data_processor.py` |
| Packages | lowercase | `mypackage` |

## Code Style

```python
# Good
def calculate_total(items):
    """Calculate the total price of items."""
    total = 0
    for item in items:
        total += item['price']
    return total

# Avoid
def calculateTotal(items):
    Total = 0
    for Item in Items:
        Total = Total + Item['price']
    return Total
```

## PEP 8 Guidelines

| Rule | Example |
|------|---------|
| 4 spaces per indentation level | `if x:` → `    pass` |
| 79 characters max per line | Use line breaks |
| Two blank lines between top-level definitions | Class, function |
| One blank line between method definitions | Inside class |
| Use spaces around operators | `a + b`, not `a+b` |
| No spaces around `=` in keyword arguments | `func(a=1)` |

## Best Practices Checklist

- [x] Follow PEP 8 style guide
- [x] Use type hints (Python 3.5+)
- [x] Write docstrings for functions/classes
- [x] Use meaningful variable names
- [x] Keep functions small and focused (1 responsibility)
- [x] Handle exceptions specifically, not bare except
- [x] Use virtual environments for each project
- [x] Use requirements.txt or poetry/pyproject.toml
- [x] Write tests (pytest, unittest)
- [x] Use linter (flake8, pylint, black formatter)

## Docstrings

```python
def add(a: int, b: int) -> int:
    """Add two numbers and return the result.
    
    Args:
        a: First number
        b: Second number
    
    Returns:
        The sum of a and b
    """
    return a + b
```

## Error Handling

```python
# Good
try:
    result = int(user_input)
except ValueError:
    print("Please enter a valid number")

# Avoid
try:
    result = int(user_input)
except:  # Too broad
    pass
```

## Related

- [[08-Virtual-Environments]] - Previous: Virtual Environments
- [[01-Introduction]] - Return to Introduction
- [[10-Best-Practices]] in [[JavaScript-Concepts]] - JavaScript best practices

## Return to [[index]]
