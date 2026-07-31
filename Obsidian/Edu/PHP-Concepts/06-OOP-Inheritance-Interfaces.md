# OOP: Inheritance and Interfaces

`extends`, method overriding, `parent::`, and `interface`/`implements`. See [[index]] for the learning path.

## Inheritance (`extends`)

A class can inherit from another class — it gets its properties and methods, and can add new ones or override existing ones.

```php
<?php
class Zwierze
{
    public function __construct(
        public string $imie,
    ) {}

    public function przedstawSie(): string
    {
        return "Jestem {$this->imie}";
    }

    public function wydajDzwiek(): string
    {
        return "...";
    }
}

class Pies extends Zwierze
{
    public function wydajDzwiek(): string
    {
        return "Hau hau!";   // overrides the base class method
    }
}

$pies = new Pies("Azor");
echo $pies->przedstawSie();   // Jestem Azor (inherited from Zwierze)
echo $pies->wydajDzwiek();    // Hau hau! (overridden in Pies)
```

- `Zwierze` is the **base/parent class**.
- `Pies` is the **derived/child class**.
- `Pies` automatically has `przedstawSie()` even though it's not defined there — inherited from `Zwierze`.
- Defining a method with the same name in the child class **overrides** the parent's version.

## `parent::` — Calling the Parent's Method

Useful in constructors, to run the parent's initialization plus extra logic:

```php
<?php
class Kot extends Zwierze
{
    public function __construct(
        string $imie,
        public bool $lubiWode = false,
    ) {
        parent::__construct($imie);   // calls Zwierze's constructor
    }

    public function wydajDzwiek(): string
    {
        return "Miau!";
    }
}
```

## Interfaces (`interface` / `implements`)

An interface is a **contract** — it declares which methods a class must have, without any implementation.

```php
<?php
interface MoznaKarmic
{
    public function nakarm(): string;
}

class Pies extends Zwierze implements MoznaKarmic
{
    public function wydajDzwiek(): string
    {
        return "Hau hau!";
    }

    public function nakarm(): string
    {
        return "{$this->imie} je karmę";
    }
}
```

- A class `implements` one or more interfaces.
- If a class `implements MoznaKarmic` but doesn't define `nakarm()`, PHP raises a fatal error — the interface **enforces** implementation.
- A class can `extends` only **one** class, but can `implements` **multiple** interfaces at once (`implements A, B, C`).

## Why Interfaces Matter

They let code depend on "something that can be fed" without caring whether it's a dog, a cat, or anything else:

```php
<?php
function nakarmZwierze(MoznaKarmic $zwierze): void
{
    echo $zwierze->nakarm();
}
```

This is central to Laravel — e.g. contracts (interfaces) used with the service container / dependency injection, where code depends on an interface rather than a concrete implementation.

## Related

- [[05-OOP-Classes-Objects]] - Previous: classes, objects, constructors
- [[index]] - Back to PHP index
