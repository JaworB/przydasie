# Agenci AI

Zrozumienie systemów agentowych AI, które mogą autonomicznie planować i wykonywać zadania.

## Czym jest agent AI?

Agent AI to system, który potrafi:
1. **Percepcja** - Postrzega swoje środowisko
2. **Rozumowanie** - Rozważa cele i opcje
3. **Planowanie** - Planuje kroki do osiągnięcia celów
4. **Działanie** - Działa używając dostępnych narzędzi
5. **Uczenie się** - Uczy się z wyników

### Agent vs. Asystent

| Asystent | Agent |
|----------|-------|
| Odpowiada na bezpośrednie żądania | Samodzielnie dąży do celów |
| Interakcje pojedyncze | Planowanie wieloetapowe |
| Ograniczona świadomość kontekstu | Świadomość środowiska |
| Przykład: ChatGPT | Przykład: Opencode z narzędziami |

## Poziomy autonomii

| Poziom | Opis | Przykład |
|--------|------|----------|
| **L0: Reaktywny** | Bez pamięci, pojedyncza odpowiedź | Podstawowy chatbot |
| **L1: Konwersacyjny** | Utrzymuje kontekst konwersacji | ChatGPT |
| **L2: Używający narzędzi** | Może wywoływać zewnętrzne narzędzia | Claude z narzędziami |
| **L3: Planujący** | Tworzy plany wieloetapowe | Opencode build agent |
| **L4: Autonomiczny** | Samodzielne dążenie do celu | Agenci badawczy |

## Architektura agenta

```
┌─────────────────────────────────────────┐
│           System agenta AI              │
├─────────────────────────────────────────┤
│  ┌─────────────┐                        │
│  │  Planowanie   │ ← Dekompozycja celu   │
│  └──────┬──────┘                        │
│         ↓                               │
│  ┌─────────────┐                        │
│  │  Rozumowanie  │ ← Łańcuch myślenia   │
│  └──────┬──────┘                        │
│         ↓                               │
│  ┌─────────────┐                        │
│  │   Działanie   │ ← Wywołania narzędzi  │
│  │   Podejmowanie │   Operacje plików    │
│  └──────┬──────┘   Polecenia           │
│         ↓                               │
│  ┌─────────────┐                        │
│  │  Uczenie się │ ← Pętla sprzężenia    │
│  └─────────────┘                        │
└─────────────────────────────────────────┘
          ↓
┌─────────────────────────────────────────┐
│  Narzędzia: bash, read, write, edit, grep   │
└─────────────────────────────────────────┘
```

## Planowanie

### Dekompozycja celu

Rozkładanie złożonych celów na zarządzalne kroki:

```
Cel: "Skonfiguruj moje środowisko deweloperskie"

Rozkład:
1. Sprawdź istniejące narzędzia
2. Zainstaluj brakujące zależności
3. Skonfiguruj pliki konfiguracyjne
4. Skonfiguruj przestrzeń roboczą
5. Sklonuj repozytoria
```

### Wzorzec ReAct

Łączenie rozumowania i działania:

```
Myśl: Muszę zrozumieć strukturę kodu
Działanie: Użyj `find` aby wyświetlić pliki
Obserwacja: Znaleziono main.py, tests/, docs/
Myśl: Teraz muszę sprawdzić wymagania
Działanie: Przeczytaj requirements.txt
Obserwacja: Django, pytest, black
...
```

## Systemy wieloagentowe

Wielu agentów współpracujących nad złożonymi zadaniami:

| Agent | Rola |
|-------|------|
| **Planista** | Tworzy ogólną strategię |
| **Badacz** | Gromadzi informacje |
| **Koder** | Pisze i edytuje kod |
| **Tester** | Waliduje zmiany |
| **Recenzent** | Kontrola jakości |

### Komunikacja agentów

```
Planista → "Zbuduj aplikację webową"
  ↓
Koder → Pisze kod
  ↓
Tester → "Testy przeszły"
  ↓
Recenzent → "Kod wygląda dobrze"
  ↓
Planista → "Zadanie ukończone"
```

## Agenci Opencode

Opencode dostarcza wbudowanych agentów:

| Agent | Cel | Użyj gdy |
|-------|-----|----------|
| **build** | Generowanie kodu, refaktoryzacja | Piszesz nowy kod |
| **general** | Pytania, wyjaśnienia | Rozumienie koncepcji |
| **explore** | Analiza kodu | Znajdowanie wzorców |

**Zobacz też:** [[08-Opencode_PL]] dla niestandardowej konfiguracji agenta.

## Użycie narzędzi

Agenci wchodzą w interakcję ze światem przez narzędzia:

| Typ narzędzia | Przykłady |
|---------------|----------|
| **Operacje plikowe** | read, write, edit, glob |
| **Powłoka** | bash, exec |
| **Szukaj** | grep, codesearch, websearch |
| **Git** | commit, push, branch |

**Zobacz też:** [[05-Tools_PL]] dla szczegółowej dokumentacji narzędzi.

## Najlepsze praktyki dla agentów

### Dobre prompty dla agentów

```
Dobrze:  "Znajdź wszystkie pliki Python które używają regex,
          zidentyfikuj wzorce i podsumuj co każdy wzorzec robi"

Źle:   "Sprawdź mój kod"
```

### Bezpieczeństwo agentów

| Zasada | Opis |
|--------|------|
| **Piaskownica** | Ogranicz dostęp agentów do wrażliwych systemów |
| **Człowiek w pętli** | Wymagaj zatwierdzenia dla działań destrukcyjnych |
| **Audyt** | Loguj wszystkie działania agentów |
| **Ograniczanie zakresu** | Zdefinuj jasne granice |

## Przykład z życia

### Opencode Build Agent

```
Użytkownik: "Utwórz web scraper Python"

Agent (build):
1. Sprawdź istniejące scrapery w kodzie
2. Utwórz scraper.py z requests beautifulsoup
3. Dodaj obsługę błędów
4. Napisz testy
5. Uruchom linting
6. Raportuj wyniki
```

## Powiązane

- [[01-Introduction_PL]] - Podstawy AI
- [[04-Prompting_PL]] - Efektywne prompty dla agentów
- [[05-Tools_PL]] - Dostępne narzędzia dla agentów
- [[08-Opencode_PL]] - Rozszerzanie agentów Opencode
