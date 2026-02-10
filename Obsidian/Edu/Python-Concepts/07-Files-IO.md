# Files & I/O

Reading from and writing to files.

## Opening Files

```python
# Modes: 'r' (read), 'w' (write), 'a' (append), 'b' (binary)
file = open("example.txt", "r")
content = file.read()
file.close()

# Better: with statement (auto-closes)
with open("example.txt", "r") as file:
    content = file.read()
```

## Reading Methods

```python
# Read entire file
with open("example.txt", "r") as file:
    content = file.read()

# Read line by line
with open("example.txt", "r") as file:
    for line in file:
        print(line.strip())

# Read all lines into list
with open("example.txt", "r") as file:
    lines = file.readlines()

# Read specific characters
with open("example.txt", "r") as file:
    chunk = file.read(100)  # First 100 characters
```

## Writing Methods

```python
# Write (overwrites)
with open("output.txt", "w") as file:
    file.write("Hello, World!\n")

# Append
with open("output.txt", "a") as file:
    file.write("Another line\n")

# Write multiple lines
lines = ["Line 1\n", "Line 2\n", "Line 3\n"]
with open("output.txt", "w") as file:
    file.writelines(lines)

# JSON
import json
data = {"name": "Alice", "age": 30}
with open("data.json", "w") as file:
    json.dump(data, file, indent=2)

# Read JSON
with open("data.json", "r") as file:
    data = json.load(file)
```

## File Paths

```python
import os

# Current directory
os.getcwd()

# List files
os.listdir(".")

# Check if exists
os.path.exists("file.txt")

# Join paths
path = os.path.join("dir", "subdir", "file.txt")

# Get absolute path
os.path.abspath("file.txt")
```

## Related

- [[06-OOP]] - Previous: OOP
- [[08-Virtual-Environments]] - Next: Virtual Environments
- [[07-Files-IO]] in [[Bash-Scripting-Concepts]] - Bash file operations

## Next Steps

Proceed to [[08-Virtual-Environments]] to learn about virtual environments.
