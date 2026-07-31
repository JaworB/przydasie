# Syntax, Variables, Data Types

Basic PHP syntax and the type system. See [[index]] for the learning path.

## PHP Tags

```php
<?php
echo "Witaj świecie!";
```

Code goes between `<?php` and (optionally omitted) `?>`.

## Variables

- Start with `$`, e.g. `$imie`.
- PHP is weakly/dynamically typed — no type declaration needed on assignment.
- Variable names are case-sensitive (`$imie` != `$Imie`).

```php
<?php
$imie = "Jan";
$wiek = 25;
$aktywny = true;
```

## Basic Types

| Type | Example |
|---|---|
| `string` | `"Jan"`, `'Jan'` |
| `int` | `25` |
| `float` | `25.5` |
| `bool` | `true`, `false` |
| `array` | `[1, 2, 3]` |
| `null` | no value |

```php
<?php
$wiek = 25;
var_dump($wiek);      // int(25)
echo gettype($wiek);  // integer
```

## String Concatenation

PHP uses `.`, not `+`:

```php
<?php
$imie = "Jan";
echo "Cześć, " . $imie . "!";   // Cześć, Jan!

// interpolation works only inside double quotes:
echo "Cześć, $imie!";
```

## Constants

```php
<?php
define("PI", 3.14);
const WERSJA = "1.0";   // modern style
```

## Related

- [[02-Control-Structures]] - Next: if/else, loops
- [[index]] - Back to PHP index
