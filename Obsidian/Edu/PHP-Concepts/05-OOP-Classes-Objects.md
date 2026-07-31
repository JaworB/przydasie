# OOP: Classes and Objects

Defining classes, creating objects, constructors, property promotion, access modifiers. See [[index]] for the learning path.

## Class Definition

```php
<?php
class Osoba
{
    public string $imie;
    public int $wiek;

    public function przywitajSie(): void
    {
        echo "Cześć, jestem {$this->imie}\n";
    }
}
```

- `class` defines a template (type); PascalCase by convention.
- `public string $imie;` is a **property** — a typed field on the object.
- `$this` refers to the specific object the method was called on.
- Inside a string, referencing an object property needs braces: `{$this->imie}`.

## Creating Objects

```php
<?php
$jan = new Osoba();
$jan->imie = "Jan";
$jan->wiek = 30;
$jan->przywitajSie();   // Cześć, jestem Jan
```

## Constructor

Runs automatically on `new`, used to initialize the object:

```php
<?php
class Osoba
{
    public string $imie;
    public int $wiek;

    public function __construct(string $imie, int $wiek)
    {
        $this->imie = $imie;
        $this->wiek = $wiek;
    }
}

$jan = new Osoba("Jan", 30);
```

## Constructor Property Promotion (PHP 8+)

Shorthand seen everywhere in Laravel — declares and assigns properties in one place:

```php
<?php
class Osoba
{
    public function __construct(
        public string $imie,
        public int $wiek,
    ) {}
}
```

Equivalent to the version above. In Laravel this is how dependency injection typically looks in controller constructors.

## Access Modifiers

| Modifier | Access |
|---|---|
| `public` | from anywhere |
| `protected` | from the class and its subclasses |
| `private` | only from within the same class |

## Core Mental Model: Class vs. Object

- A **class** is a template — it defines what properties and methods every object of that type will have. The class itself stores no data.
- An **object** is a concrete instance created from that template. Each object has its **own copy** of the properties (independent state in memory), but **shares** the same method code defined once on the class.
- When calling `$produkt->wartosc()`, PHP runs the `wartosc()` code from the class but binds `$this` to that specific object — same method body, different `$this` each time, hence different results per object.
- There is no implicit way to reference an object other than through a variable (or array/property) that holds it — no lookup by call order, name guessing, etc. Also: PHP variable names cannot start with a digit (`$3` is a parse error).
- Mutating state through a method (e.g. `$this->pensja += ...`) only affects the one object the method was called on — other objects of the same class, even sitting in the same array, are untouched.

## Exercises Solved

`edu/php/zadanie4.php` — a `Produkt` class with promoted properties, a value-computing method, and a formatting method, used over an array of objects:

```php
<?php
class Produkt
{
    public function __construct(
        public string $nazwa,
        public float $cena,
        public int $ilosc,
    ) {}

    public function wartosc(): float
    {
        return $this->cena * $this->ilosc;
    }

    public function opis(): string
    {
        return $this->nazwa . ": " . $this->ilosc . " szt. x " . $this->cena . " zł = " . $this->wartosc();
    }
}

$produkty = [
    new Produkt("Chleb", 4.50, 3),
    new Produkt("Mleko", 3.20, 2),
    new Produkt("Masło", 8.00, 1),
    new Produkt("Ser", 15.00, 1),
];

$sumaCalkowita = 0;
foreach ($produkty as $produkt) {
    echo $produkt->opis() . "\n";
    $sumaCalkowita += $produkt->wartosc();
}
echo "Koszyk: " . $sumaCalkowita . " zł.\n";
```

`edu/php/zadanie5.php` — a `Pracownik` class demonstrating that a method mutating `$this` only affects the one object it's called on:

```php
<?php
class Pracownik
{
    public function __construct(
        public string $imie,
        public string $stanowisko,
        public float $pensja,
    ) {}

    public function podwyzka(float $procent): void
    {
        $this->pensja += $this->pensja * $procent;
    }

    public function wizytowka(): string
    {
        return "{$this->imie} ({$this->stanowisko}) - {$this->pensja} zł";
    }
}

$pracownicy = [
    new Pracownik("Jan Kowalski", "Programista", 10000),
    new Pracownik("Grzegorz Gerwazy", "Spawacz", 12000),
    new Pracownik("Pakur Pakuras", "Monter", 9000),
];

foreach ($pracownicy as $pracownik) {
    echo $pracownik->wizytowka() . "\n";
}

$pracownicy[0]->podwyzka(0.1);
echo $pracownicy[0]->wizytowka();   // only Jan's pensja changes, the other two are untouched
```

Common mistakes caught during these exercises:
- Inside a method, constructor parameters are **not** available as plain variables (`$cena`) — only as `$this->cena` (the promoted property).
- A property vs. a method are accessed the same way syntactically (`->`) but a method needs the call parentheses: `$this->wartosc()`, not `$this->wartosc`.
- A statement like `$this->pensja * $procent;` computes a value and discards it — it must be assigned back (`$this->pensja = ...` or `+=`) to actually change state.
- `return;` (no value) returns `null` — to return a built-up variable, write `return $variableName;`.

## Related

- [[06-OOP-Inheritance-Interfaces]] - Next: extends, parent::, interfaces
- [[index]] - Back to PHP index
