# Control Structures

if/elseif/else, switch/match, and loops. See [[index]] for the learning path.

## if / elseif / else

```php
<?php
$wiek = 20;

if ($wiek < 13) {
    echo "Dziecko";
} elseif ($wiek < 18) {
    echo "Nastolatek";
} else {
    echo "Dorosły";
}
```

## Comparison and Logical Operators

| Operator | Meaning |
|---|---|
| `==` | equal by value (`"5" == 5` → true) |
| `===` | equal by value **and type** (`"5" === 5` → false) |
| `!=`, `!==` | not equal (analogous) |
| `&&`, `\|\|`, `!` | AND, OR, NOT |

Prefer `===` over `==` — avoids surprises when comparing different types.

## switch / match

```php
<?php
switch ($dzien) {
    case "pon":
        echo "Poniedziałek";
        break;
    default:
        echo "Inny dzień";
}

// PHP 8+ equivalent, no break, uses === comparison:
$wynik = match ($dzien) {
    "pon" => "Poniedziałek",
    default => "Inny dzień",
};
```

## Loops

```php
<?php
for ($i = 0; $i < 5; $i++) { echo $i; }

$i = 0;
while ($i < 5) { echo $i; $i++; }

// foreach — most common for arrays
foreach ($owoce as $owoc) { echo $owoc; }
```

## Exercises Solved

`edu/php/zadanie1.php` — classify numbers in an array as even/odd, plus flag numbers over 20:

```php
<?php
$liczby = [4, 15, 8, 23, 42, 7];
$komunikat = "";

foreach ($liczby as $liczba) {
    if ($liczba % 2 === 0) {
        $komunikat = "$liczba jest parzysta";
    } else {
        $komunikat = "$liczba jest nieparzysta";
    }
    if ($liczba > 20) {
        $komunikat .= " i jest duża.";
    }
    $komunikat .= "\n";
    echo $komunikat;
}
```

Key lessons from this exercise:
- Every statement needs a trailing `;` — the most common early syntax error.
- `.=` appends to a string, useful for building up a conditional message before printing it once.
- `echo` does not add a newline — append `"\n"` explicitly.

## Related

- [[03-Functions]] - Next: functions
- [[index]] - Back to PHP index
