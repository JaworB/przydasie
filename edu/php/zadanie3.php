<?php
$produkty =
    [
    ["nazwa" => "Chleb", "cena" => 4.50, "ilosc" => 3],
    ["nazwa" => "Mleko", "cena" => 3.20, "ilosc" => 2],
    ["nazwa" => "Masło", "cena" => 8.00, "ilosc" => 1],
    ["nazwa" => "Ser", "cena" => 15.00, "ilosc" => 1],
];
$sumaCalkowita =0;

foreach ($produkty as $produkt) {
    $suma = $produkt["ilosc"] * $produkt["cena"];
    echo $produkt["nazwa"] .": ". $produkt["ilosc"] . " szt. " . "x " . $produkt["cena"] . " zł = " . $suma . " zł";
    echo "\n";
    $sumaCalkowita += $suma;
}
echo "Koszyk: " . $sumaCalkowita . " zł.\n";

$drogie = array_filter($produkty, fn($p) => $p["cena"] > 5);
print_r($drogie);
$nazwyDrogich = array_map(fn($p) => $p["nazwa"], $drogie);
echo "Drogie produkty: " . implode(", ", $nazwyDrogich);
