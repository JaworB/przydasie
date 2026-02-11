# Podstawowe koncepcje AI

Zrozumienie działania LLM, w tym tokenów, osadzeń i okien kontekstowych.

## Jak działają LLM

### Przegląd architektury

Duże modele językowe oparte są na architekturze **Transformer**:

```
Tekst wejściowy → Tokenizacja → Osadzenie → Warstwy Transformera → Wynik → Detokenizacja
```

### Tokenizacja

Tokeny są podstawowymi jednostkami przetwarzanymi przez LLM:

| Tekst | Tokeny |
|-------|--------|
| "AI" | ["AI"] |
| "Hello world" | ["Hello", " world"] |
| "The quick brown fox" | ["The", " quick", " brown", " fox"] |

**Kluczowe fakty:**
- Około 4 znaków na token
- 1000 tokenów ≈ 750 słów
- Cena jest zazwyczaj za 1M tokenów

### Osadzenia

Osadzenia konwertują tokeny na wektory numeryczne, które przechwytują znaczenie:

```
Słowo → [0.2, -0.5, 0.8, ...] (wektor wysokowymiarowy)
```

**Właściwości:**
- Podobne słowa mają podobne wektory
- Mogą reprezentować relacje semantyczne
- Umożliwiają operacje matematyczne (król - mężczyzna + kobieta ≈ królowa)

## Okno kontekstowe

Okno kontekstowe to maksymalna liczba tokenów, którą model może przetworzyć:

| Model | Okno kontekstowe |
|-------|-----------------|
| GPT-4 | 128K tokenów |
| Claude | 200K+ tokenów |
| Minimax | Zmienne |

### Implikacje

```
Okno kontekstowe = Pamięć + Pamięć robocza

W kontekście:     Model pamięta wszystko
Poza kontekstem:  Model "zapomina" informacji
```

**Strategie optymalizacji:**
- Obcinanie starej historii konwersacji
- Podsumowywanie długich dokumentów
- Użycie RAG dla dużych baz wiedzy (zobacz [[06-RAG-VectorDB_PL]])

## Temperatura

Temperatura kontroluje losowość w wyniku:

| Temperatura | Zachowanie | Przypadek użycia |
|-------------|------------|------------------|
| 0.0 | Deterministyczny, ten sam wynik za każdym razem | Kod, odpowiedzi faktyczne |
| 0.3-0.7 | Zrównoważona kreatywność | Ogólna konwersacja |
| 0.8-1.0 | Wysoka kreatywność, zróżnicowany wynik | Kreatywne pisanie |
| 1.0+ | Chaotyczny, nieprzewidywalny | Eksperymentalne |

**Przykład kodu:**
```json
{
  "temperature": 0.2,
  "top_p": 0.9
}
```

## Parametry modelu

Parametry to "wagi" wyuczone podczas treningu:

| Model | Parametry |
|-------|------------|
| GPT-3 | 175 miliardów |
| GPT-4 | ~1,76 biliona (szacunkowo) |
| Llama 2 | 7B - 70B |
| Claude | Nieznane (Anthropic) |

**Więcej parametrów nie zawsze znaczy lepiej:**
- Jakość treningu ma znaczenie
- Dostrajanie może przewyższać większe modele ogólne
- Koszt wnioskowania rośnie z liczbą parametrów

## Generowanie wyniku

### Predykcja następnego tokenu

LLM przewidują jeden token na raz:

```
Wejście: "Stolica Francji to"
↓
Model przewiduje: ["Paryż" (0.95), "Londyn" (0.02), ...]
↓
Wybierz token → Dodaj do wejścia → Powtórz
```

### Strategie próbkowania

| Strategia | Opis |
|-----------|------|
| **Zachłanne** | Zawsze wybierz najwyższą probabilistykę |
| **Top-p** | Próbkuj z górnych X% masy probabilistycznej |
| **Top-k** | Próbkuj z K najbardziej prawdopodobnych tokenów |

## Podsumowanie kluczowych koncepcji

| Koncepcja | Opis |
|-----------|------|
| **Token** | Podstawowa jednostka tekstu (~4 znaki) |
| **Osadzenie** | Wektor numeryczny reprezentujący znaczenie tokenu |
| **Okno kontekstowe** | Maksymalna liczba tokenów które model może przetworzyć |
| **Temperatura** | Kontroluje losowość wyniku |
| **Parametry** | Wyuczone wagi w modelu |
| **Wnioskowanie** | Użycie modelu do generowania wyniku |
| **Dostrajanie** | Dodatkowy trening na konkretnych danych |

## Rozważania dotyczące wydajności

### Limity tokenów

| Akcja | Użyte tokeny |
|-------|--------------|
| System prompt | 500-1000 |
| 1000 słów | ~1300 |
| 100 linii kodu | ~4000 |

### Optymalizacja kosztów

```
# Minimalizuj tokeny przy zachowaniu jakości

Dobrze:  "Wyjaśnij fizykę kwantową w 2 zdaniach"
Źle:   "Proszę, jeśli byłbyś tak uprzejmy, czy mógłbyś wyjaśnić fizykę kwantową?"
```

## Powiązane

- [[01-Introduction_PL]] - Podstawy AI
- [[04-Prompting_PL]] - Efektywny projekt promptów
- [[06-RAG-VectorDB_PL]] - Zarządzanie dużymi kontekstami
- [[09-Best-Practices_PL]] - Optymalizacja tokenów
