# RAG i bazy wektorowe

Generowanie wzbogacone o wyszukiwanie dla aplikacji AI intensywnie wykorzystujących wiedzę.

## Czym jest RAG?

Generowanie wzbogacone o wyszukiwanie łączy:
1. **Wyszukiwanie** - Znajdowanie istotnych informacji
2. **Wzbogacanie** - Dodawanie kontekstu do promptów
3. **Generowanie** - Produkowanie odpowiedzi AI

```
┌─────────────────────────────────────────────────────┐
│                  Pipeline RAG                        │
├─────────────────────────────────────────────────────┤
│                                                     │
│  Zapytanie ──→ Osadzenie ──→ Baza wektorowa ──→ Wyszukaj   │
│                ↓                    ↓              │
│            (konwertuj)            (podobne dokumenty)       │
│                               ↓                    │
│  Prompt ← Wzbogać ──→ Kontekst + Zapytanie ────────────┘
│                                                     │
│                        ↓                            │
│                  Odpowiedź LLM                       │
│                                                     │
└─────────────────────────────────────────────────────┘
```

## Dlaczego RAG?

### Problemy które rozwiązuje RAG

| Problem | Rozwiązanie RAG |
|---------|----------------|
| Ograniczenie wiedzy | Pobierz najnowsze informacje |
| Halucynacje | Zakotwiczone w prawdziwych dokumentach |
| Limity kontekstu | Selektywne wyszukiwanie |
| Nieaktualne treningi | Dostęp do świeżych danych |

### Przypadki użycia

| Domena | Aplikacja |
|--------|------------|
| **Dokumentacja** | Q&A bazie kodu, dokumentacja API |
| **Wiedza** | Osobiste wiki, badania |
| **Korporacyjne** | Dokumenty wewnętrzne, polityki |
| **Wsparcie** | Boty obsługi klienta |

## Bazy wektorowe

### Czym są wektory?

Wektory to numeryczne reprezentacje tekstu:

```
Tekst: "Jak zainstalować Pythona"
      ↓
Wektor: [0.2, -0.5, 0.8, 0.1, ...]  # 1536 wymiarów
```

**Kluczowa właściwość:** Podobny tekst = podobne wektory

### Operacje bazy wektorowej

| Operacja | Opis |
|----------|------|
| **Upsert** | Przechowuj wektory z metadanymi |
| **Szukaj** | Znajdź podobne wektory |
| **Filtruj** | Stosuj filtry metadanych |
| **Usuń** | Usuń wektory |

### Popularne bazy wektorowe

| Baza | Opis | Przypadek użycia |
|------|------|------------------|
| **Pinecone** | Zarządzana, skalowalna | Produkcja RAG |
| **Weaviate** | Open source | Self-hosted |
| **Chroma** | Lekka | Prototypowanie |
| **FAISS** | Biblioteka Facebooka | Lokalne wyszukiwanie |
| **pgvector** | Rozszerzenie PostgreSQL | SQL + wektory |

## Osadzenia

### Czym są osadzenia?

Osadzenia konwertują tekst na wektory:

| Tekst | Model osadzenia |
|------|----------------|
| Krótki tekst | text-embedding-3-small |
| Długi tekst | text-embedding-3-large |
| Kod | Specjalistyczne osadzenia kodu |

### Modele osadzeń

| Dostawca | Model | Wymiary |
|----------|-------|---------|
| OpenAI | text-embedding-3-small | 1536 |
| OpenAI | text-embedding-3-large | 3072 |
| Cohere | embed-multilingual-v3.0 | 1024 |

## Implementacja RAG

### Przetwarzanie dokumentów

```
Dokument → Chunkowanie → Osadzenie → Baza wektorowa
```

### Strategie chunkowania

| Strategia | Opis | Zalety/wady |
|----------|------|-------------|
| **Stały rozmiar** | 500-1000 tokenów/chunk | Proste, może łamać kontekst |
| **Semantyczny** | Dziel według akapitów | Zachowuje znaczenie |
| **Hierarchiczny** | Dokument → Sekcja → Chunk | Najlepsza struktura |

### Przykład: Chunkowanie dokumentu

```python
# Chunkowanie stałego rozmiaru
chunk_size = 1000
chunks = []

for i in range(0, len(text), chunk_size):
    chunk = text[i:i + chunk_size]
    chunks.append(chunk)

# Osadź każdy chunk
embeddings = [embed(chunk) for chunk in chunks]

# Przechowuj w bazie wektorowej
for chunk, embedding in zip(chunks, embeddings):
    db.upsert(
        vectors=[embedding],
        metadata={"text": chunk}
    )
```

### Wyszukiwanie

```python
# Osadzenie zapytania
query_embedding = embed(user_query)

# Szukaj
results = db.search(
    query=query_embedding,
    top_k=5,
    filter={"source": "docs"}
)

# Pobierz kontekst
context = "\n\n".join([r.metadata["text"] for r in results])
```

### Wzbogacanie

```python
prompt = f"""
Użyj następującego kontekstu do odpowiedzi na pytanie.

Kontekst:
{context}

Pytanie: {user_query}

Odpowiedź:
"""
```

## RAG + Opencode

### Konfiguracja bazy wiedzy

```
~/.opencode/
├── knowledge/           # Twoje dokumenty
│   ├── docs/
│   ├── manuals/
│   └── notes/
└── embeddings/          # Osadzenia z cache
```

### Używanie RAG w Opencode

```
1. Załaduj wiedzę do bazy wektorowej
2. Zapytaj o istotne dokumenty
3. Uwzględnij w kontekście agenta
4. Pobierz zakotwiczone odpowiedzi
```

**Zobacz też:** [[08-Opencode_PL]] dla konfiguracji RAG w Opencode.

## Optymalizacja zapytań

### Efektywne zapytania RAG

| Podejście | Przykład |
|-----------|----------|
| **Konkretne** | "Jak skonfigurować skróty klawiszowe Hyprland?" |
| **Kontekstowe** | "W bindings.conf, jaka jest składnia dla SUPER+SHIFT?" |
| **Filtrowane** | "Znajdź notatki OBSIDIAN o Docker" |

### Wyszukiwanie hybrydowe

Łączenie wyszukiwania wektorowego ze słowami kluczowymi:

```
vector_results = vector_search(query, top_k=10)
keyword_results = keyword_search(query, top_k=10)

# Połącz i ponownie ranguj
results = rerank(vector_results + keyword_results)
```

## Najlepsze praktyki RAG

### Organizacja dokumentów

```
docs/
├── index.md              # Punkt wejścia
├── getting-started.md    # Szybki samouczek
├── reference/           # Szczegółowa dokumentacja
│   ├── api.md
│   └── config.md
└── guides/              # Instrukcje
    └── installation.md
```

### Metadane

Dodaj bogate metadane do chunków:

```json
{
  "text": "Składnia pliku konfiguracyjnego...",
  "source": "docs/config.md",
  "section": "Konfiguracja",
  "headings": "Wprowadzenie > Konfiguracja",
  "last_updated": "2024-01-15"
}
```

### Ewaluacja

| Metryka | Opis |
|---------|------|
| **Precyzja** | % istotnych dokumentów |
| **Pokrycie** | % znalezionych istotnych dokumentów |
| **Wskaźnik trafień** | % zapytań z wynikami |

## Powiązane

- [[01-Introduction_PL]] - Podstawy AI
- [[02-Core-Concepts_PL]] - Koncepcje LLM
- [[04-Prompting_PL]] - Promptowanie z uwzględnieniem kontekstu
- [[08-Opencode_PL]] - RAG w Opencode
