# Object-Oriented Programming

Classes and objects in Python.

## Classes

```python
class Dog:
    # Class attribute
    species = "Canis familiaris"
    
    # Initializer (constructor)
    def __init__(self, name, age):
        self.name = name  # Instance attribute
        self.age = age
    
    # Instance method
    def bark(self):
        return f"{self.name} says Woof!"
    
    # String representation
    def __str__(self):
        return f"{self.name} is {self.age} years old"
```

## Creating Objects

```python
# Instantiate class
my_dog = Dog("Buddy", 3)

# Access attributes
print(my_dog.name)      # Buddy
print(my_dog.bark())    # Buddy says Woof!
print(my_dog)           # Buddy is 3 years old
```

## Inheritance

```python
class GoldenRetriever(Dog):
    def fetch(self):
        return f"{self.name} fetches the ball!"

my_golden = GoldenRetriever("Charlie", 5)
print(my_golden.bark())    # From parent class
print(my_golden.fetch())  # From child class

# isinstance check
isinstance(my_golden, Dog)       # True
isinstance(my_golden, GoldenRetriever)  # True
```

## Encapsulation

```python
class BankAccount:
    def __init__(self, balance=0):
        self._balance = balance  # Protected (convention)
    
    @property
    def balance(self):
        return self._balance
    
    def deposit(self, amount):
        if amount > 0:
            self._balance += amount
    
    def withdraw(self, amount):
        if 0 < amount <= self._balance:
            self._balance -= amount
            return True
        return False

account = BankAccount(100)
print(account.balance)  # 100
account.deposit(50)
print(account.balance)  # 150
```

## Related

- [[05-Control-Flow]] - Previous: Control Flow
- [[07-Files-IO]] - Next: Files and I/O
- [[04-Objects]] in [[JavaScript-Concepts]] - JavaScript objects

## Next Steps

Proceed to [[07-Files-IO]] to learn about file operations.
