# Data Structures

Python's built-in data structures.

## Lists

```python
# Ordered, mutable collection
fruits = ["apple", "banana", "cherry"]

# Access
fruits[0]       # "apple"
fruits[-1]      # "cherry"

# Modify
fruits.append("date")      # Add to end
fruits.insert(1, "apricot")  # Insert at index
fruits.remove("banana")    # Remove by value
fruits.pop()              # Remove and return last
del fruits[0]             # Remove by index

# Methods
fruits.sort()
fruits.reverse()
fruits.extend(["fig", "grape"])
```

## Tuples

```python
# Ordered, immutable collection
coordinates = (10, 20, 30)

# Access (same as list)
coordinates[0]  # 10

# Unpacking
x, y, z = coordinates
```

## Dictionaries

```python
# Key-value pairs
user = {
    "name": "Alice",
    "age": 30,
    "city": "NYC"
}

# Access
user["name"]      # "Alice" (KeyError if missing)
user.get("name")  # "Alice" (None if missing)
user.get("email", "N/A")  # "N/A" as default

# Modify
user["email"] = "alice@example.com"
user["age"] = 31

# Methods
user.keys()
user.values()
user.items()
```

## Sets

```python
# Unordered, unique elements
numbers = {1, 2, 3, 4, 5}

# Add/remove
numbers.add(6)
numbers.remove(3)      # KeyError if missing
numbers.discard(3)     # No error if missing

# Operations
set1 = {1, 2, 3}
set2 = {2, 3, 4}

set1 | set2  # Union: {1, 2, 3, 4}
set1 & set2  # Intersection: {2, 3}
set1 - set2  # Difference: {1}
```

## Related

- [[03-Functions]] - Previous: Functions
- [[05-Control-Flow]] - Next: Control Flow
- [[06-OOP]] - Data structures in classes

## Next Steps

Proceed to [[05-Control-Flow]] to learn about control flow statements.
