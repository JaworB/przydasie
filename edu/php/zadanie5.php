<?php

class Pracownik {
    public function __construct(
        public string $imie,
        public string $stanowisko,
        public float $pensja,
    )
    {}

    public function podwyzka(float $procent): void 
    {
        $this->pensja = $this->pensja + ($this->pensja * $procent);
    }

    public function wizytowka() : string
    {
        return "{$this->imie} ({$this->stanowisko}) - {$this->pensja}";
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
echo $pracownicy[0]->wizytowka();

#Definiuje klasę Pracownik z właściwościami (przez constructor property promotion): imie (string), stanowisko (string), pensja (float).
#Dodaje metodę podwyzka(float $procent): void, która zwiększa $this->pensja o podany procent (np. podwyzka(10) przy pensji 4000 daje 4400). Metoda niczego nie zwraca — modyfikuje stan obiektu 
#(jak urodziny() w przykładzie z Piesem).
#Dodaje metodę wizytowka(): string, która zwraca string w formacie:
#"Jan Kowalski (Programista) - 4400 zł"
#(czyli imie (stanowisko) - pensja zł).
#Tworzy tablicę 3-4 obiektów Pracownik z różnymi danymi.
#W pętli foreach wypisuje wizytowka() każdego pracownika.
#Po pętli, wywołuje podwyzka(15) tylko na jednym, konkretnym pracowniku z tablicy (np. przez indeks $pracownicy[0]), a potem jeszcze raz wypisuje jego wizytowka(), żeby zobaczyć zmianę.
