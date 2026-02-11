# RAG and Vector Databases

Retrieval-augmented generation for knowledge-intensive AI applications.

## What is RAG?

Retrieval-Augmented Generation combines:
1. **Retrieval** - Finding relevant information
2. **Augmentation** - Adding context to prompts
3. **Generation** - Producing AI responses

```
┌─────────────────────────────────────────────────────┐
│                    RAG Pipeline                      │
├─────────────────────────────────────────────────────┤
│                                                     │
│  Query ──→ Embedding ──→ Vector DB ──→ Retrieve   │
│                 ↓                    ↓              │
│            (convert)            (similar docs)       │
│                               ↓                    │
│  Prompt ← Augment ──→ Context + Query ────────────┘
│                                                     │
│                        ↓                            │
│                  LLM Response                       │
│                                                     │
└─────────────────────────────────────────────────────┘
```

## Why RAG?

### Problems RAG Solves

| Problem | RAG Solution |
|---------|--------------|
| Knowledge cutoff | Retrieve latest info |
| Hallucinations | Grounded in real docs |
| Context limits | Selective retrieval |
| Stale training | Fresh data access |

### Use Cases

| Domain | Application |
|--------|-------------|
| **Documentation** | Codebase Q&A, API docs |
| **Knowledge** | Personal wikis, research |
| **Enterprise** | Internal docs, policies |
| **Support** | Customer service bots |

## Vector Databases

### What Are Vectors?

Vectors are numerical representations of text:

```
Text: "How to install Python"
     ↓
Vector: [0.2, -0.5, 0.8, 0.1, ...]  # 1536 dimensions
```

**Key property:** Similar text = similar vectors

### Vector Database Operations

| Operation | Description |
|-----------|-------------|
| **Upsert** | Store vectors with metadata |
| **Search** | Find similar vectors |
| **Filter** | Apply metadata filters |
| **Delete** | Remove vectors |

### Popular Vector Databases

| Database | Description | Use Case |
|----------|-------------|----------|
| **Pinecone** | Managed, scalable | Production RAG |
| **Weaviate** | Open source | Self-hosted |
| **Chroma** | Lightweight | Prototyping |
| **FAISS** | Facebook's library | Local search |
| **pgvector** | PostgreSQL extension | SQL + vectors |

## Embeddings

### What are Embeddings?

Embeddings convert text to vectors:

| Text | Embedding Model |
|------|-----------------|
| Short text | text-embedding-3-small |
| Long text | text-embedding-3-large |
| Code | Specialized code embeddings |

### Embedding Models

| Provider | Model | Dimensions |
|----------|-------|------------|
| OpenAI | text-embedding-3-small | 1536 |
| OpenAI | text-embedding-3-large | 3072 |
| Cohere | embed-multilingual-v3.0 | 1024 |

## RAG Implementation

### Document Processing

```
Document → Chunking → Embedding → Vector DB
```

### Chunking Strategies

| Strategy | Description | Pros/Cons |
|----------|-------------|-----------|
| **Fixed Size** | 500-1000 tokens/chunk | Simple, may break context |
| **Semantic** | Split by paragraphs | Preserves meaning |
| **Hierarchical** | Document → Section → Chunk | Best structure |

### Example: Document Chunking

```python
# Fixed size chunking
chunk_size = 1000
chunks = []

for i in range(0, len(text), chunk_size):
    chunk = text[i:i + chunk_size]
    chunks.append(chunk)

# Embed each chunk
embeddings = [embed(chunk) for chunk in chunks]

# Store in vector DB
for chunk, embedding in zip(chunks, embeddings):
    db.upsert(
        vectors=[embedding],
        metadata={"text": chunk}
    )
```

### Retrieval

```python
# Query embedding
query_embedding = embed(user_query)

# Search
results = db.search(
    query=query_embedding,
    top_k=5,
    filter={"source": "docs"}
)

# Get context
context = "\n\n".join([r.metadata["text"] for r in results])
```

### Augmentation

```python
prompt = f"""
Use the following context to answer the question.

Context:
{context}

Question: {user_query}

Answer:
"""
```

## RAG + Opencode

### Knowledge Base Setup

```
~/.opencode/
├── knowledge/           # Your documents
│   ├── docs/
│   ├── manuals/
│   └── notes/
└── embeddings/          # Cached embeddings
```

### Using RAG in Opencode

```
1. Load knowledge into vector DB
2. Query relevant docs
3. Include in agent context
4. Get grounded responses
```

**See also:** [[08-Opencode]] for Opencode RAG configuration.

## Query Optimization

### Effective RAG Queries

| Approach | Example |
|----------|---------|
| **Specific** | "How do I configure Hyprland keybindings?" |
| **Contextual** | "In bindings.conf, what's the syntax for SUPER+SHIFT?" |
| **Filtered** | "Find OBSIDIAN notes about Docker" |

### Hybrid Search

Combine vector search with keywords:

```
vector_results = vector_search(query, top_k=10)
keyword_results = keyword_search(query, top_k=10)

# Merge and re-rank
results = rerank(vector_results + keyword_results)
```

## RAG Best Practices

### Document Organization

```
docs/
├── index.md              # Entry point
├── getting-started.md    # Quick tutorial
├── reference/           # Detailed docs
│   ├── api.md
│   └── config.md
└── guides/              # How-tos
    └── installation.md
```

### Metadata

Add rich metadata to chunks:

```json
{
  "text": "Configuration file syntax...",
  "source": "docs/config.md",
  "section": "Configuration",
  "headings": "Getting Started > Configuration",
  "last_updated": "2024-01-15"
}
```

### Evaluation

| Metric | Description |
|--------|-------------|
| **Precision** | % of retrieved docs relevant |
| **Recall** | % of relevant docs retrieved |
| **Hit Rate** | % of queries with results |

## Related

- [[01-Introduction]] - AI basics
- [[02-Core-Concepts]] - LLM concepts
- [[04-Prompting]] - Context-aware prompting
- [[08-Opencode]] - RAG in Opencode
