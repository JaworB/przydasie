# Narzędzia i wywoływanie funkcji

Jak systemy AI używają narzędzi do interakcji ze światem.

## Czym są narzędzia?

Narzędzia to funkcje, które agenci AI mogą wywoływać, by działać:

```
Agent AI → Wywołanie narzędzia → Wykonanie narzędzia → Wynik → Agent AI
```

## Kategorie narzędzi

| Kategoria | Cel | Przykłady |
|-----------|-----|----------|
| **Operacje plikowe** | Odczyt, zapis, modyfikacja plików | read, write, edit, glob |
| **Polecenia powłoki** | Wykonywanie poleceń terminalowych | bash, exec |
| **Szukaj** | Znajdowanie informacji | grep, codesearch, websearch |
| **Operacje Git** | Kontrola wersji | commit, push, branch |
| **Web** | Pobieranie treści webowych | webfetch |
| **Specjalistyczne** | Domenowe | skill, todowrite |

## Definicja narzędzia

### Schemat narzędzia

```json
{
  "name": "bash",
  "description": "Wykonaj polecenie powłoki",
  "parameters": {
    "command": "string",
    "description": "string",
    "timeout": "number (opcjonalne)"
  }
}
```

### Wynik narzędzia

```json
{
  "success": true,
  "output": "wyjście polecenia",
  "error": null
}
```

## Operacje plikowe

### read

Odczytaj zawartość pliku:

```
Narzędzie: read
Args: { filePath: "/ścieżka/do/pliku" }
Zwraca: Zawartość pliku
```

### write

Utwórz lub nadpisz pliki:

```
Narzędzie: write
Args: {
  filePath: "/ścieżka/do/pliku",
  content: "zawartość pliku"
}
Zwraca: Potwierdzenie
```

### edit

Modyfikuj określone części plików:

```
Narzędzie: edit
Args: {
  filePath: "/ścieżka/do/pliku",
  oldString: "tekst do zamiany",
  newString: "tekst zamienny"
}
Zwraca: Potwierdzenie lub błąd
```

### glob

Znajdź pliki według wzorca:

```
Narzędzie: glob
Args: {
  pattern: "**/*.py",
  path: "/projekt" (opcjonalne)
}
Zwraca: Lista pasujących plików
```

## Polecenia powłoki

### bash

Wykonuj polecenia z opcjonalnym timeout:

```json
{
  "command": "ls -la",
  "description": "Wyświetl pliki ze szczegółami",
  "timeout": 30000
}
```

**Najlepsze praktyki:**
- Zawsze dodawaj opis
- Ustaw odpowiedni timeout
- Używaj ścieżek bezwzględnych gdy możliwe
- Obsługuj błędy elegancko

## Narzędzia wyszukiwania

### grep

Szukaj w zawartości plików:

```json
{
  "pattern": "function.*test",
  "path": "/projekt",
  "include": "*.py"
}
```

### codesearch

Szukaj wzorców programistycznych:

```json
{
  "query": "React useState hook examples",
  "tokensNum": 5000
}
```

### websearch

Badania webowe:

```json
{
  "query": "Python async await best practices 2024",
  "numResults": 5
}
```

## Operacje Git

| Narzędzie | Cel |
|----------|-----|
| git status | Sprawdź stan repozytorium |
| git add | Stage zmian |
| git commit | Utwórz commity |
| git push | Wyślij do zdalnego |
| git diff | Wyświetl zmiany |

## Kompozycja narzędzi

Łączenie narzędzi dla złożonych zadań:

```
1. glob → Znajdź pliki
   ↓
2. read → Przejrzyj zawartość
   ↓
3. edit → Modyfikuj pliki
   ↓
4. bash → Uruchom testy
   ↓
5. git commit → Zapisz zmiany
```

## Obsługa błędów

### Błąd narzędzia

```json
{
  "success": false,
  "error": "Plik nie znaleziony",
  "output": null
}
```

### Strategie naprawy

| Typ błędu | Obsługa |
|-----------|---------|
| Plik nie znaleziony | Sprawdź ścieżkę, utwórz jeśli potrzeba |
| Brak uprawnień | Sprawdź uprawnienia, użyj sudo |
| Polecenie nie powiodło się | Spróbuj ponownie, sprawdź składnię |
| Timeout | Zwiększ timeout, optymalizuj polecenie |

## Najlepsze praktyki

### Wybór narzędzia

```
Wybierz WŁAŚCIWE narzędzie do zadania:

- Odczytać plik? → read
- Utworzyć plik? → write
- Zmodyfikować zawartość? → edit
- Znaleźć pliki? → glob
- Szukać zawartości? → grep
- Uruchomić polecenia? → bash
```

### Pisanie efektywnych narzędzi

| Zasada | Opis |
|--------|------|
| Atomowe | Rób jedną rzecz dobrze |
| Udokumentowane | Jasny opis |
| Idempotentne | Bezpieczne do wielokrotnego wywołania |
| Świadome błędów | Obsługuj przypadki brzegowe |

## Bezpieczeństwo narzędzi

### Kategorie ryzyka

| Ryzyko | Mitygacja |
|--------|-----------|
| Wstrzykiwanie poleceń | Sanityzuj wejścia |
| Przechodzenie ścieżek | Waliduj ścieżki |
| Ekspozycja danych | Ogranicz wyjście |
| Eskalacja uprawnień | Użyj najmniejszych uprawnień |

### Bezpieczne wzorce

```bash
# Dobrze: Konkretne polecenia
bash({ command: "ls -la /project" })

# Źle: Polecenia kontrolowane przez użytkownika
bash({ command: user_input })
```

## Narzędzia Opencode

Opencode dostarcza tych wbudowanych narzędzi:

| Narzędzie | Opis |
|-----------|------|
| bash | Wykonuj polecenia powłoki |
| read | Odczytuj zawartość pliku |
| write | Twórz/nadpisuj pliki |
| edit | Modyfikuj zawartość pliku |
| glob | Znajdź pliki według wzorca |
| grep | Szukaj w zawartości plików |
| codesearch | Szukaj wzorców programistycznych |
| websearch | Badania webowe |
| webfetch | Pobierz zawartość URL |
| skill | Ładuj umiejętności |
| todowrite | Zarządzanie zadaniami |

**Zobacz też:** [[08-Opencode_PL]] dla konfiguracji narzędzi specyficznej dla Opencode.

## Powiązane

- [[03-Agents_PL]] - Jak agenci używają narzędzi
- [[04-Prompting_PL]] - Promptowanie dla użycia narzędzi
- [[08-Opencode_PL]] - Referencja narzędzi Opencode
- [[Bash-Scripting-Concepts_PL]] - Skryptowanie dla narzędzi
