<?php

function ocenaLiczby (int $liczba): string
{
    $komunikat = "";
    if ($liczba > 0) {
        $komunikat = "dodatnia";
    } elseif ($liczba < 0) {
        $komunikat = "ujemna";
    } else {
        $komunikat = "zero";
    }

    if ($liczba % 2 === 0 and $liczba > 0 ) {
        $komunikat .= " i parzysta";
    } elseif ($liczba % 2 != 0 and $liczba > 0) {
        $komunikat .= " i nieparzysta";
    }
    return $komunikat;
}

function opisz(int $liczba, string $prefix = "Liczba"):void 
{
    echo "$prefix $liczba to: " . ocenaLiczby($liczba) . "\n";
}

$tabela = [-5, 0, 12, 7];

foreach ($tabela as $i) {
    opisz($i);
}

opisz(3,"Wynik");