# Środowiska wirtualne

Zarządzanie zależnościami z venv i pip.

## Tworzenie środowiska

```bash
# Utwórz środowisko
python -m venv moje_środowisko

# Aktywuj (Linux/macOS)
source moje_środowisko/bin/activate

# Aktywuj (Windows)
moje_środowisko\Scripts\activate

# Dezaktywuj
deactivate
```

## pip - menedżer pakietów

```bash
# Zainstaluj pakiet
pip install requests

# Zainstaluj z requirements.txt
pip install -r requirements.txt

# Wygeneruj requirements.txt
pip freeze > requirements.txt

# Odinstaluj pakiet
pip uninstall requests

# Lista zainstalowanych pakietów
pip list

# Szukaj pakietu
pip search requests
```

## requirements.txt

```
requests==2.28.0
numpy>=1.21.0
pandas
flask>=2.0.0
```

## Virtualenv (alternatywa)

```bash
# Instalacja
pip install virtualenv

# Tworzenie
virtualenv moje_venv

# Aktywacja
source moje_venv/bin/activate
```

## Najlepsze praktyki

- Zawsze używaj środowisk wirtualnych
- Dodaj środowisko do `.gitignore`
- Commituj `requirements.txt`
- Używaj konkretnych wersji

## .gitignore dla Python

```
__pycache__/
*.py[cod]
*$py.class
*.so
.Python
venv/
env/
.venv/
.env
```

## Powiązane

- [[07-Files-IO_PL]] - Poprzednie: Pliki I/O
- [[09-Best-Practices_PL]] - Następne: Najlepsze praktyki
- [[../Docker-Concepts/index_PL]] - Konteneryzacja

## Następne kroki

Przejdź do [[09-Best-Practices_PL]] aby dowiedzieć się o najlepszych praktykach.
