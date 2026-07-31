<?php

class Produkt
{
    public function __construct(
        public string $nazwa,
        public float $cena,
        public int $ilosc,
    )
    {}
    public function wartosc(): float
    {
        return $this->cena * $this->ilosc;
    }
    public function opis(): string {
        $opis = "";
        $opis .= $this->nazwa .": ". $this->ilosc . " szt. " . "x " . $this->cena . " zł = " . $this->wartosc() ;
        return $opis;
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
