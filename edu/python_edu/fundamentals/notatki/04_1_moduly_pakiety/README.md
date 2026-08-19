# Temat 4.1 - Moduly i pakiety

Ten temat inaczej niż poprzednie - potrzebne osobne pliki, żeby zademonstrować
import (jeden plik nie może "zaimportować sam siebie").

Uruchom po kolei z tego katalogu:

    python3 main.py     # import matematyka, from ... import ... as ..., __name__
    python3 matematyka.py   # ten sam plik uruchomiony bezpośrednio - if __name__ == "__main__"
    python3 main2.py     # import z pakietu (projekt/ z __init__.py)

Pliki:
- matematyka.py   - prosty moduł: funkcje + stała + blok if __name__ == "__main__"
- main.py         - import matematyka, from matematyka import odejmij as minus
- projekt/        - pakiet (ma __init__.py) z modułem tekst.py
- main2.py        - from projekt.tekst import ...  oraz  from projekt import tekst
