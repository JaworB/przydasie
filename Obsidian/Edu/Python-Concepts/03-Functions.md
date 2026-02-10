# Functions

Creating and using functions in Python.

## Function Definition

```python
# Basic function
def greet(name):
    return f"Hello, {name}!"

# Call function
result = greet("Alice")
print(result)  # Hello, Alice!
```

## Parameters & Arguments

```python
# Default parameters
def greet(name, greeting="Hello"):
    return f"{greeting}, {name}!"

# Keyword arguments
greet(name="Bob", greeting="Hi")

# *args (positional)
def sum_numbers(*args):
    return sum(args)

sum_numbers(1, 2, 3, 4, 5)  # 15

# **kwargs (keyword)
def print_info(**kwargs):
    for key, value in kwargs.items():
        print(f"{key}: {value}")

print_info(name="Alice", age=30)
```

## Return Values

```python
# Single return
def add(a, b):
    return a + b

# Multiple returns (returns tuple)
def get_stats(numbers):
    total = sum(numbers)
    average = total / len(numbers)
    return total, average

total, avg = get_stats([1, 2, 3, 4, 5])
```

## Lambda Functions

```python
# Anonymous function
square = lambda x: x ** 2
print(square(5))  # 25

# With filter
numbers = [1, 2, 3, 4, 5]
evens = list(filter(lambda x: x % 2 == 0, numbers))
```

## Related

- [[02-Variables-Types]] - Previous: Variables
- [[04-Data-Structures]] - Next: Data Structures
- [[06-OOP]] - Classes with methods

## Next Steps

Proceed to [[04-Data-Structures]] to learn about data structures.
