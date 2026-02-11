# Wprowadzenie do AI

Zrozumienie sztucznej inteligencji, jej typów oraz relacji do uczenia maszynowego.

## Czym jest sztuczna inteligencja?

AI odnosi się do systemów zdolnych do wykonywania zadań typowo wymagających ludzkiej inteligencji:
- **Rozumowanie** - Wyciąganie wniosków z informacji
- **Uczenie się** - Doskonalenie na podstawie doświadczenia
- **Rozwiązywanie problemów** - Znajdowanie rozwiązań złożonych wyzwań
- **Percepcja** - Rozumienie danych sensorycznych (tekst, obrazy, audio)
- **Język** - Rozumienie i generowanie ludzkiego języka

## Typy AI

### Wąska AI (Słaba AI)

Wąska AI specjalizuje się w konkretnym zadaniu:

| Przykład | Możliwości |
|----------|------------|
| ChatGPT | Konwersacja, generowanie tekstu |
| Generatory obrazów | Tworzenie obrazów z promptów |
| Rozpoznawanie mowy | Konwersja audio na tekst |
| Systemy rekomendacyjne | Sugerowanie produktów/treści |
| Twoi agenci AI | Automatyzacja zadań |

**Obecny stan AI:** Posiadamy potężną wąską AI, ale nie mamy ogólnej sztucznej inteligencji.

### Ogólna inteligencja artificialna (AGI)

AGI byłaby zdolna do nauki dowolnego zadania intelektualnego, które człowiek potrafi:
- **Jeszcze nie osiągnięte** - Pomimo postępów, żaden system nie posiada prawdziwej inteligencji ogólnej
- **Trwające badania** - Wiele osób uważa, że to kwestia dziesięcioleci
- **Obawy bezpieczeństwa** - Rozwój AGI budzi istotne pytania etyczne

## Podstawy uczenia maszynowego

### Czym jest uczenie maszynowe?

ML to podzbiór AI, gdzie systemy uczą się z danych, zamiast być explicite programowane:

```
Programowanie tradycyjne:  Dane + Reguły → Wynik
Uczenie maszynowe:          Dane + Wynik → Reguły
```

### Typy ML

| Typ | Opis | Przykład |
|-----|------|----------|
| **Uczenie nadzorowane** | Nauka z oznaczonych danych | Klasyfikacja spamu |
| **Uczenie nienadzorowane** | Znajdowanie wzorców w nieoznakowanych danych | Segmentacja klientów |
| **Uczenie ze wzmocnieniem** | Nauka z nagroód/kar | Granie w gry |
| **Głębokie uczenie** | Sieci neuronowe z wieloma warstwami | Rozpoznawanie obrazów |

### Duże modele językowe (LLM)

LLM to typ głębokiego uczenia trenowany na ogromnych ilościach tekstu:

| Komponent | Opis |
|-----------|------|
| **Trenowanie** | Nauka wzorców z tekstu w skali internetowej |
| **Parametry** | Miliardy "wag" które kodują wiedzę (GPT-4 ma około 1,76 biliona) |
| **Wnioskowanie** | Generowanie odpowiedzi na prompty |
| **Dostrajanie** | Adaptacja modeli do konkretnych zadań |

## Historia AI

| Rok | Kamień milowy |
|-----|---------------|
| 1950 | Test Turinga zaproponowany przez Alana Turinga |
| 1956 | Konferencja Dartmouth - AI nazwane jako dziedzina |
| 1966 | ELIZA - Pierwszy chatbot (dopasowywanie wzorców) |
| 1997 | Deep Blue pokonuje Kasparowa w szachach |
| 2012 | AlexNet - Rewolucja głębokiego uczenia w rozpoznawaniu obrazów |
| 2017 | Architektura Transformer wprowadzona (Attention Is All You Need) |
| 2020 | GPT-3 - 175 miliardów parametrów |
| 2022 | ChatGPT uruchomiony - Spopularyzowani asystenci AI |
| 2023 | GPT-4, Claude, Llama - Pojawiają się modele multimodalne |
| 2024+ | Specjalizowani agenci, RAG, AI korporacyjne |

## Kluczowe terminy

| Term | Definicja |
|------|-----------|
| **Model** | Wytrenowany system AI (GPT-4, Claude, Llama) |
| **Wnioskowanie** | Użycie wytrenowanego modelu do przewidywań |
| **Token** | Jednostka tekstu (około 4 znaków) |
| **Okno kontekstowe** | Maksymalna liczba tokenów jaką model może zobaczyć |
| **Temperatura** | Kontroluje losowość w wyniku (0 = deterministyczne) |
| **Dostrajanie** | Dalsze treningi na konkretnych danych |
| **Prompt** | Tekst wejściowy który kieruje wynikiem modelu |

## AI w praktyce

### Obecne zastosowania

| Domena | Przykładowe użycie |
|--------|-------------------|
| **Kod** | Uzupełnianie kodu, naprawianie błędów, dokumentacja |
| **Pisanie** | Szkice, edycja, tłumaczenie |
| **Analiza** | Interpretacja danych, podsumowywanie |
| **Automatyzacja** | Agenci AI, automatyzacja przepływów pracy |
| **Badania** | Przegląd literatury, generowanie hipotez |

### AI dla inżynierii oprogramowania

Narzędzia AI transformują sposób budowania oprogramowania:
- **Generowanie kodu** - Szkice, testy, dokumentacja
- **Debugowanie** - Znajdowanie i naprawianie błędów
- **Refaktoryzacja** - Poprawa struktury kodu
- **Dokumentacja** - Generowanie i utrzymywanie dokumentacji
- **Automatyzacja** - Agenci AI do ukończenia zadań

**Zobacz też:** [[08-Opencode_PL]] o rozszerzaniu agentów AI dla Twojego przepływu pracy.

## Powiązane

- [[02-Core-Concepts_PL]] - Wnętrzności LLM
- [[03-Agents_PL]] - Systemy agentowe AI
- [[08-Opencode_PL]] - Praktyczne rozszerzenie agenta AI
