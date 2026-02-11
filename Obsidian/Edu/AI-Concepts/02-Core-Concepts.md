# Core AI Concepts

Understanding how LLMs work, including tokens, embeddings, and context windows.

## How LLMs Work

### Architecture Overview

Large Language Models are based on the **Transformer** architecture:

```
Input Text → Tokenization → Embedding → Transformer Layers → Output → Detokenization
```

### Tokenization

Tokens are the basic units LLMs process:

| Text | Tokens |
|------|--------|
| "AI" | ["AI"] |
| "Hello world" | ["Hello", " world"] |
| "The quick brown fox" | ["The", " quick", " brown", " fox"] |

**Key facts:**
- ~4 characters per token on average
- 1000 tokens ≈ 750 words
- Pricing is typically per 1M tokens

### Embeddings

Embeddings convert tokens into numerical vectors that capture meaning:

```
Word → [0.2, -0.5, 0.8, ...] (high-dimensional vector)
```

**Properties:**
- Similar words have similar vectors
- Can represent semantic relationships
- Enable mathematical operations (king - man + woman ≈ queen)

## Context Window

The context window is the maximum tokens a model can process:

| Model | Context Window |
|-------|---------------|
| GPT-4 | 128K tokens |
| Claude | 200K+ tokens |
| Minimax | Variable |

### Implications

```
Context Window = Memory + Working Memory

Within context:     Model remembers everything
Outside context:    Model "forgets" information
```

**Optimization strategies:**
- Truncate old conversation history
- Summarize long documents
- Use RAG for large knowledge bases (see [[06-RAG-VectorDB]])

## Temperature

Temperature controls randomness in output:

| Temperature | Behavior | Use Case |
|-------------|----------|----------|
| 0.0 | Deterministic, same output every time | Code, factual responses |
| 0.3-0.7 | Balanced creativity | General conversation |
| 0.8-1.0 | High creativity, varied output | Creative writing |
| 1.0+ | Chaotic, unpredictable | Experimental |

**Code example:**
```json
{
  "temperature": 0.2,
  "top_p": 0.9
}
```

## Model Parameters

Parameters are the "weights" learned during training:

| Model | Parameters |
|-------|------------|
| GPT-3 | 175 billion |
| GPT-4 | ~1.76 trillion (estimated) |
| Llama 2 | 7B - 70B |
| Claude | Unknown (Anthropic) |

**More parameters ≠ always better:**
- Training quality matters
- Fine-tuning can outperform larger general models
- Inference cost increases with parameter count

## Output Generation

### Next-Token Prediction

LLMs predict one token at a time:

```
Input: "The capital of France is"
↓
Model predicts: ["Paris" (0.95), "London" (0.02), ...]
↓
Select token → Append to input → Repeat
```

### Sampling Strategies

| Strategy | Description |
|----------|-------------|
| **Greedy** | Always pick highest probability |
| **Top-p** | Sample from top X% probability mass |
| **Top-k** | Sample from top K most likely tokens |

## Key Concepts Summary

| Concept | Description |
|---------|-------------|
| **Token** | Basic unit of text (~4 characters) |
| **Embedding** | Numerical vector representing token meaning |
| **Context Window** | Maximum tokens model can process |
| **Temperature** | Controls output randomness |
| **Parameters** | Learned weights in the model |
| **Inference** | Using the model to generate output |
| **Fine-tuning** | Additional training on specific data |

## Performance Considerations

### Token Limits

| Action | Tokens Used |
|--------|-------------|
| System prompt | 500-1000 |
| 1000 words | ~1300 |
| 100 lines of code | ~4000 |

### Cost Optimization

```
# Minimize tokens while maintaining quality

Good:  "Explain quantum physics in 2 sentences"
Bad:   "Please, if you would be so kind, could you explain quantum physics?"
```

## Related

- [[01-Introduction]] - AI basics
- [[04-Prompting]] - Effective prompt design
- [[06-RAG-VectorDB]] - Managing large contexts
- [[09-Best-Practices]] - Token optimization
