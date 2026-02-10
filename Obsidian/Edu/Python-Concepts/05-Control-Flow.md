# Control Flow

Controlling program execution in Python.

## if Statements

```python
age = 18

if age >= 18:
    print("Adult")
elif age >= 13:
    print("Teenager")
else:
    print("Child")
```

## Ternary Operator

```python
status = "Adult" if age >= 18 else "Minor"
```

## for Loops

```python
# Loop through sequence
fruits = ["apple", "banana", "cherry"]
for fruit in fruits:
    print(fruit)

# Loop with range
for i in range(5):          # 0, 1, 2, 3, 4
    print(i)

for i in range(1, 6):      # 1, 2, 3, 4, 5
    print(i)

for i in range(0, 10, 2):  # 0, 2, 4, 6, 8 (step 2)
    print(i)
```

## while Loops

```python
count = 0
while count < 5:
    print(count)
    count += 1
```

## Loop Control

```python
# break - exit loop
for i in range(10):
    if i == 5:
        break
    print(i)  # 0, 1, 2, 3, 4

# continue - skip iteration
for i in range(5):
    if i == 2:
        continue
    print(i)  # 0, 1, 3, 4

# else clause (runs if no break)
for i in range(5):
    if i == 10:
        break
else:
    print("Loop completed without break")
```

## List Comprehensions

```python
# Basic
squares = [x**2 for x in range(10)]

# With condition
evens = [x for x in range(10) if x % 2 == 0]

# Nested
matrix = [[i+j for j in range(3)] for i in range(3)]
```

## Related

- [[04-Data-Structures]] - Previous: Data Structures
- [[06-OOP]] - Next: Object-Oriented Programming
- [[05-Control-Flow]] in [[Bash-Scripting-Concepts]] - Bash control flow

## Next Steps

Proceed to [[06-OOP]] to learn about object-oriented programming.
