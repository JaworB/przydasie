# Inżynieria Promptów

Techniki tworzenia efektywnych promptów, które dają lepsze odpowiedzi AI.

## Podstawy promptów

Prompt to wejście, które kieruje wynikiem AI:

```
Jakość promptu → Jakość odpowiedzi

Niejasne:     "Pomóż mi z kodem"
Konkretne:  "Napisz funkcję Python która waliduje adresy email
             używając regex, z testami jednostkowymi"
```

## Struktura promptu

```
┌────────────────────────────────────────────┐
│ SYSTEM MESSAGE                             │
│ (Rola, zachowanie, ograniczenia)           │
├────────────────────────────────────────────┤
│ CONTEXT                                    │
│ (Informacje tło)                            │
├────────────────────────────────────────────┤
│ TASK                                       │
│ (Co zrobić)                                │
├────────────────────────────────────────────┤
│ CONSTRAINTS                                │
│ (Format, długość, styl)                    │
├────────────────────────────────────────────┤
│ EXAMPLES                                   │
│ (Przykłady few-shot)                        │
└────────────────────────────────────────────┘
```

## Techniki promptowania

### Promptowanie Zero-Shot

Bez przykładów, bezpośrednie żądanie:

```
Prompt: "Sklasyfikuj sentyment: Kocham ten produkt"
Wynik: "Pozytywny"
```

### Promptowanie Few-Shot

Przykłady włączone:

```
Prompt: """
Przykłady sentymentu:
"To jest niesamowite!" → Pozytywne
"To jest okropne." → Negatywne
"Nie wiem co myśleć o tym." → Neutralne
"Świetna wartość za pieniądze!" →
Wynik: "Pozytywne"
```

### Łańcuch myślenia (CoT)

Zachęcanie do rozumowania krok po kroku:

```
Prompt: """
Q: Jeśli mam 3 jabłka i kupuję 5 więcej, daję 2 przyjacielowi,
   ile mam?

Pomyślmy krok po kroku:
1. Zaczynam od 3 jabłek
2. Kupuję 5 więcej: 3 + 5 = 8
3. Daję 2: 8 - 2 = 6

Odpowiedź: 6
"""
```

### ReAct (Reason + Act)

Łączenie rozumowania z użyciem narzędzi:

```
Myśl: Muszę znaleźć strukturę plików
Działanie: Użyj `find` aby zlokalizować pliki Python
Obserwacja: Znaleziono 15 plików .py
Myśl: Teraz muszę zrozumieć główny punkt wejścia
Działanie: Przeczytaj main.py
...
```

## Szablony promptów

### Generowanie kodu

```markdown
Jesteś ekspertem {language} developerem.

Zadanie: Napisz funkcję {function_type}

Wymagania:
- Nazwa funkcji: {name}
- Wejście: {input_type}
- Wyjście: {output_type}
- Dołącz obsługę błędów
- Postępuj zgodnie z {style_guide}

Zwróć tylko kod, bez wyjaśnień.
```

### Code Review

```markdown
Jesteś senior code reviewerem.

Przejrzyj następujący kod pod kątem:
- Błędy i problemy bezpieczeństwa
- Problemy wydajnościowe
- Naruszenia stylu kodu
- Brakujące testy

Kod:
```{language}
{code}
```

Sformatuj przegląd jako:
## Znalezione problemy
- [ważność] {opis}

## Rekomendacje
- {sugestia}
```

### Dokumentacja

```markdown
Jesteś pisarzem technicznym.

Zadanie: Udokumentuj następujący kod

Wymagania:
- Wyjaśnij cel w 2 zdaniach
- Udokumentuj wszystkie parametry
- Dołącz przykłady użycia
- Wyjaśnij wartości zwracane

Kod:
```{language}
{code}
```
```

## Iteracyjne promptowanie

Poprawianie wyników przez doprecyzowanie:

```
1. Początkowy prompt: "Napisz funkcję Python"
   ↓
2. Dodaj ograniczenia: "Dodaj type hints i obsługę błędów"
   ↓
3. Określ format: "Użyj dataclass, postępuj z PEP 8"
   ↓
4. Wersja finalna zoptymalizowana
```

## Częste błędy

| Błąd | Lepsze podejście |
|------|------------------|
| Zbyt niejasny | Bądź konkretny co do wejścia/wyjścia |
| Brak ograniczeń | Zdefiniuj format, długość, styl |
| Zbyt wiele zadań | Jedno zadanie na prompt |
| Brak przykładów | Dołącz przykłady few-shot |
| Niejasna rola | Jasno zdefiniuj rolę systemu |

## Inżynieria promptów dla kodu

### Pisanie kodu

```
Dobrze: "Utwórz funkcję Python do odczytu plików CSV z:
       - pandas
       - Type hints (pd.DataFrame) -> dict
       - Obsługa brakujących wartości
       - Zwróć typy kolumn"

Źle: "Napisz kod do odczytu CSV"
```

### Debugowanie

```
"Debuguj ten kod Python:

```python
{code}
```

Błąd: {error}

Wyjaśnij przyczynę i sugeruj naprawę."
```

### Wyjaśnianie kodu

```
"Wyjaśnij ten kod początkującemu:

```python
{code}
```

Użyj prostych słów, unikaj żargonu, podaj przykłady."
```

## Optymalizacja promptów

### Efektywność tokenów

| Podejście | Tokeny | Jakość |
|-----------|--------|--------|
| Rozwlekłe wyjaśnienie | Wysoka | Ta sama |
| Zwięzły, konkretny | Niska | Ta sama |

### Zarządzanie kontekstem

```
Dla długiego kontekstu:
1. Podsumuj tło
2. Skup się na istotnych szczegółach
3. Użyj jawnych znaczników sekcji
```

## Zaawansowane techniki

### Persona Prompting

```markdown
Jesteś {persona}.

{opis_persony}

Odpowiadaj w stylu {persona}.
```

### Programowanie ograniczeń

```markdown
Ograniczenia:
- Maksymalnie {n} linii
- Użyj tylko biblioteki standardowej
- Brak zewnętrznych zależności
- Musi przejść {test_suite}
```

### Kontrola formatu

```markdown
Format wyniku: JSON

{
  "function_name": "",
  "parameters": [{"name": "", "type": ""}],
  "return_type": "",
  "description": ""
}
```

## Powiązane

- [[01-Introduction_PL]] - Podstawy AI
- [[02-Core-Concepts_PL]] - Rozumienie modeli
- [[03-Agents_PL]] - Promptowanie agentów
- [[08-Opencode_PL]] - Wzorce promptów Opencode
