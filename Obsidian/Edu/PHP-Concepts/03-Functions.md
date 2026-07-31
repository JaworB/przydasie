# Functions

Declarations, return values, type hinting, named arguments, closures. See [[index]] for the learning path.

## Basics

```php
<?php
function powitanie($imie) {
    echo "Cześć, $imie!\n";
}

powitanie("Jan");
```

## return

```php
<?php
function dodaj($a, $b) {
    return $a + $b;
}

$wynik = dodaj(3, 5);   // 8
```

`return` immediately ends the function — code after it never runs.

## Default Argument Values

```php
<?php
function powitanie($imie = "Gościu") {
    echo "Cześć, $imie!\n";
}

powitanie();          // Cześć, Gościu!
powitanie("Anna");    // Cześć, Anna!
```

## Type Hinting

Heavily used throughout Laravel:

```php
<?php
function dodaj(int $a, int $b): int {
    return $a + $b;
}
```

Passing the wrong type raises a `TypeError` — catches mistakes early.

## Named Arguments (PHP 8+)

```php
<?php
function przedstaw(string $imie, int $wiek) {
    echo "$imie ma $wiek lat";
}

przedstaw(wiek: 30, imie: "Anna");   // order doesn't matter
```

## Closures / Anonymous Functions

Central to Laravel (e.g. route definitions):

```php
<?php
$kwadrat = function ($x) { return $x * $x; };
echo $kwadrat(5);   // 25

// arrow function (PHP 7.4+), short form:
$kwadrat = fn($x) => $x * $x;
```

## `void` Return Type

Declares that a function returns nothing (no `return $value;`, only side effects like `echo`):

```php
public function przywitajSie(): void
{
    echo "Cześć\n";
}
```

Returning a value from a `void` function is a compile-time error in PHP.

## Exercises Solved

`edu/php/zadanie2.php` — one function computes and returns a classification, a second function formats and prints it:

```php
<?php
function ocenaLiczby(int $liczba): string
{
    $komunikat = "";
    if ($liczba > 0) {
        $komunikat = "dodatnia";
    } elseif ($liczba < 0) {
        $komunikat = "ujemna";
    } else {
        $komunikat = "zero";
    }

    if ($liczba % 2 === 0 and $liczba > 0) {
        $komunikat .= " i parzysta \n";
    } elseif ($liczba % 2 != 0 and $liczba > 0) {
        $komunikat .= " i nieparzysta \n";
    }
    return $komunikat;
}

function opisz(int $liczba, string $prefix = "Liczba"): void
{
    echo "$prefix $liczba to: " . ocenaLiczby($liczba) . "\n";
}

$tabela = [-5, 0, 12, 7];
foreach ($tabela as $i) {
    opisz($i);
}
opisz(3, "Wynik");
```

Key lessons from this exercise:
- A function that **computes and returns** a value (`ocenaLiczby`) should stay separate from one that **formats/prints** (`opisz`) — mixing the two (e.g. adding `\n` inside the computing function) caused a double-newline bug.
- A loop variable inside a function will silently shadow a same-named parameter — putting the `foreach` inside `opisz()` instead of outside it made the `$liczba` parameter unreachable.
- You cannot call a function directly inside a double-quoted string (`"...ocenaLiczby($liczba)..."` just prints the literal text) — concatenate the call result with `.` instead.

## Related

- [[04-Arrays]] - Next: arrays
- [[index]] - Back to PHP index
