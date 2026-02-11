# Najlepsze praktyki

Standardy kodowania i rekomendacje dla Python (PEP 8).

## PEP 8 - Styl kodu

| Reguła | Przykład |
|--------|----------|
| Nazwy zmiennych | `zmienna_lokalna` (snake_case) |
| Stałe | `STAŁA_KONSTANTA` |
| Funkcje | `funkcja_przykładowa()` |
| Klasy | `KlasaPrzykładowa` |
| Pakiety | `pakiet_przykładowy` |
| Odstępy | 4 spacje na poziom wcięcia |

## Przykład dobrego stylu

```python
# Dobrze
def oblicz_srednia(liczby):
    """
    Oblicza średnią arytmetyczną listy liczb.
    """
    if not liczby:
        raise ValueError("Lista nie może być pusta")
    
    suma = sum(liczby)
    return suma / len(liczby)


# Źle (unikaj)
def obliczSrednia(L):
    if L!=[]:
        s=sum(L)
        return s/len(L)
```

## Lista kontrolna

- [x] Używaj snake_case dla zmiennych i funkcji
- [x] Używaj PascalCase dla klas
- [x] Dodawaj docstringi
- [x] Zachowuj 4 spacje wcięcia
- [x] Używaj lintera (flake8, pylint)
- [x] Formatuj automatycznie (black, autopep8)
- [x] Pisz testy (pytest, unittest)

## Narzędzia

```bash
# Sprawdzanie stylu
pip install flake8
flake8 moj_modul.py

# Automatyczne formatowanie
pip install black
black moj_modul.py

# Typowanie (opcjonalne)
pip install mypy
mypy moj_modul.py
```

## Importy

```python
# Dobrze (pogrupowane, alfabetycznie)
import os
import sys
from pathlib import Path

import numpy as np
import pandas as pd

# Źle
import sys, os
from pathlib import Path
import pandas
```

## Komentarze i docstringi

```python
# Komentarz liniowy
# To jest komentarz wyjaśniający

# Docstring
def funkcja():
    """
    Krótki opis funkcji.

    Args:
        param1: Opis parametru

    Returns:
        Opis zwracanej wartości
    """
    pass
```

## Powiązane

- [[08-Virtual-Environments_PL]] - Poprzednie: Środowiska wirtualne
- [[01-Introduction_PL]] - Wróć do wprowadzenia
- [[10-Best-Practices_PL]] w [[../JavaScript/index_PL]] - Najlepsze praktyki JavaScript

## Wróć do [[index_PL]]
