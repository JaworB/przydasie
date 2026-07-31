# Arrays

Indexed and associative arrays, foreach, array_map/array_filter. See [[index]] for the learning path.

## Indexed Arrays

```php
<?php
$owoce = ["jabłko", "gruszka", "śliwka"];
echo $owoce[0];        // jabłko
echo count($owoce);    // 3
$owoce[] = "banan";    // append
```

## Associative Arrays

```php
<?php
$osoba = ["imie" => "Jan", "wiek" => 30, "miasto" => "Warszawa"];
echo $osoba["imie"];   // Jan
$osoba["email"] = "jan@example.com";
```

Close to what a database row or form data looks like in Laravel.

## foreach with Key and Value

```php
<?php
foreach ($osoba as $klucz => $wartosc) {
    echo "$klucz: $wartosc\n";
}
```

## Multidimensional Arrays

```php
<?php
$osoby = [
    ["imie" => "Jan", "wiek" => 30],
    ["imie" => "Anna", "wiek" => 25],
];

foreach ($osoby as $osoba) {
    echo $osoba["imie"] . " ma " . $osoba["wiek"] . " lat\n";
}
```

## Useful Array Functions

| Function | Does |
|---|---|
| `count($t)` | number of elements |
| `in_array($x, $t)` | is `$x` present |
| `array_key_exists($k, $t)` | does key exist |
| `sort($t)` | sorts (mutates original) |
| `array_map(fn, $t)` | new array, function applied to each element |
| `array_filter(fn, $t)` | new array, only elements passing the predicate |

```php
<?php
$liczby = [1, 2, 3, 4, 5];
$podwojone = array_map(fn($n) => $n * 2, $liczby);        // [2, 4, 6, 8, 10]
$parzyste = array_filter($liczby, fn($n) => $n % 2 === 0); // [2, 4] — keys preserved!
```

`array_map`/`array_filter` combined with arrow functions is a very common style in Laravel, especially with Eloquent collections.

## Debugging Arrays

`echo` cannot print an array directly (raises `Array to string conversion` and prints just `Array`). Use:

```php
<?php
print_r($drogie);   // readable, formatted view
var_dump($drogie);  // more detail, includes types
```

## Exercises Solved

`edu/php/zadanie3.php` — shopping cart total and filtering:

```php
<?php
$produkty = [
    ["nazwa" => "Chleb", "cena" => 4.50, "ilosc" => 3],
    ["nazwa" => "Mleko", "cena" => 3.20, "ilosc" => 2],
    ["nazwa" => "Masło", "cena" => 8.00, "ilosc" => 1],
    ["nazwa" => "Ser", "cena" => 15.00, "ilosc" => 1],
];
$sumaCalkowita = 0;

foreach ($produkty as $produkt) {
    $suma = $produkt["ilosc"] * $produkt["cena"];
    echo $produkt["nazwa"] . ": " . $produkt["ilosc"] . " szt. x " . $produkt["cena"] . " zł = " . $suma . " zł\n";
    $sumaCalkowita += $suma;
}
echo "Koszyk: " . $sumaCalkowita . " zł.\n";

$drogie = array_filter($produkty, fn($p) => $p["cena"] > 5);
print_r($drogie);
$nazwyDrogich = array_map(fn($p) => $p["nazwa"], $drogie);
echo "Drogie produkty: " . implode(", ", $nazwyDrogich);
```

Key lessons from this exercise:
- `array_filter` **preserves the original keys** — filtering out an early element leaves a "gap" in the numbering (visible via `print_r`), it does not reindex.
- To get just one field (e.g. names) out of an array of associative arrays, chain `array_filter` (keep the right rows) with `array_map` (extract the field), then `implode(", ", $arr)` to join into a display string.

## Related

- OOP (next, in progress) - classes, objects, inheritance, interfaces
- [[index]] - Back to PHP index
