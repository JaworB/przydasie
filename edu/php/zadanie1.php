<?php
$liczby = [4, 15, 8, 23, 42, 7];
$komunikat = "";

foreach ($liczby as $liczba) {
    if ( $liczba % 2 === 0 ) {
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