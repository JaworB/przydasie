# AI Models

Comparing different AI language models and their capabilities.

## Model Categories

### By Provider

| Provider | Models | Strengths |
|----------|--------|-----------|
| **OpenAI** | GPT-4, GPT-4o, GPT-3.5 | Versatility, ecosystem |
| **Anthropic** | Claude 3 (Haiku, Sonnet, Opus) | Long context, safety |
| **Google** | Gemini 1.5 | Multimodal, long context |
| **ama 3Meta** | Ll | Open source, fine-tuning |
| **xAI** | Grok | Real-time info |
| **Minimax** | Various | Opencode integration |

### By Capability

| Tier | Models | Use Case |
|------|--------|----------|
| **Reasoning** | GPT-4, Claude 3 Opus | Complex analysis |
| **Fast/cheap** | GPT-3.5, Claude Haiku | Simple tasks |
| **Coding** | GPT-4, Claude | Code generation |
| **Long context** | Claude, Gemini | Large documents |

## Major Models

### OpenAI GPT-4

| Aspect | Details |
|--------|---------|
| **Context** | 128K tokens |
| **Strengths** | Coding, reasoning, creativity |
| **Weaknesses** | Cost, rate limits |
| **Best for** | Complex tasks, code, analysis |

### Anthropic Claude 3

| Model | Context | Strengths |
|-------|---------|-----------|
| **Haiku** | 200K | Fast, efficient |
| **Sonnet** | 200K | Balanced |
| **Opus** | 200K | Deep reasoning |

**Key features:**
- Claude 3.5 Sonnet: Excellent coding
- Long context: 200K+ tokens
- Safety-aligned responses

### Google Gemini

| Model | Context | Strengths |
|-------|---------|-----------|
| **1.5 Flash** | 1M+ | Fast, multimodal |
| **1.5 Pro** | 1M+ | Reasoning, coding |

**Key features:**
- Massive context window
- Native multimodal (text, images, video)
- Google ecosystem integration

### Meta Llama 3

| Model | Parameters | Strengths |
|-------|------------|-----------|
| **Llama 3 8B** | 8B | Fast, efficient |
| **Llama 3 70B** | 70B | Balanced |

**Key features:**
- Open source (Meta license)
- Fine-tuneable
- Strong instruction following

### Minimax (Opencode)

| Aspect | Details |
|--------|---------|
| **Context** | Variable |
| **Strengths** | Opencode optimization |
| **Best for** | CLI-based workflows |

## Model Comparison

| Model | Coding | Math | Reasoning | Creative | Context |
|-------|--------|------|-----------|----------|---------|
| GPT-4 | ★★★★★ | ★★★★ | ★★★★★ | ★★★★ | ★★★ |
| Claude 3 Opus | ★★★★ | ★★★★ | ★★★★★ | ★★★★★ | ★★★★ |
| Claude 3.5 Sonnet | ★★★★★ | ★★★ | ★★★★ | ★★★★ | ★★★★ |
| Gemini 1.5 Pro | ★★★★ | ★★★★ | ★★★★ | ★★★ | ★★★★★ |
| Llama 3 70B | ★★★ | ★★★ | ★★★ | ★★★ | ★★ |

## Selecting a Model

### Decision Framework

| Requirement | Recommended Model |
|-------------|------------------|
| **Complex coding** | GPT-4, Claude 3.5 Sonnet |
| **Long documents** | Claude 3, Gemini 1.5 |
| **Budget-conscious** | Claude Haiku, GPT-3.5 |
| **Fine-tuning** | Llama 3 |
| **Real-time info** | Grok |
| **CLI automation** | Minimax (Opencode) |

### Cost Considerations

| Model | Input ($/1M tokens) | Output ($/1M tokens) |
|-------|---------------------|----------------------|
| GPT-4o | $5.00 | $15.00 |
| GPT-3.5 Turbo | $0.50 | $1.50 |
| Claude 3 Haiku | $0.25 | $1.25 |
| Claude 3 Sonnet | $3.00 | $15.00 |
| Claude 3 Opus | $15.00 | $75.00 |

## Model Capabilities

### Coding

```markdown
Best for code: GPT-4, Claude 3.5 Sonnet

Capabilities:
- Generate boilerplate
- Debug errors
- Refactor code
- Write tests
- Explain code
```

### Math

```markdown
Best for math: GPT-4, Claude 3 Opus

Capabilities:
- Step-by-step reasoning
- Formula derivation
- Statistical analysis
```

### Creative Writing

```markdown
Best for creative: Claude 3 Opus, GPT-4

Capabilities:
- Story generation
- Style mimicry
- Marketing copy
- Technical writing
```

### Analysis

```markdown
Best for analysis: Claude 3 Opus, Gemini 1.5 Pro

Capabilities:
- Document summarization
- Pattern recognition
- Data interpretation
```

## Fine-Tuning

### When to Fine-Tune

| Situation | Consider Fine-tuning |
|-----------|----------------------|
| Specialized domain | Medical, legal, finance |
| Specific format | Code style, document templates |
| Proprietary data | Internal knowledge |
| Cost optimization | Smaller model with fine-tuning |

### Fine-Tuning Providers

| Platform | Models |
|----------|--------|
| OpenAI | GPT-3.5, GPT-4 |
| Anthropic | Not available |
| Hugging Face | Llama, Mistral |
| Openrouter | Various |

## Model Context

### Context Windows

| Model | Tokens | Approximate |
|-------|--------|-------------|
| Claude 3 | 200K | 500 pages |
| Gemini 1.5 | 1M+ | 1000+ pages |
| GPT-4 | 128K | 300 pages |
| Llama 3 | 8K | 20 pages |

### Managing Context

```
Context optimization strategies:

1. Summarize long documents
2. Remove redundant information
3. Use RAG for large knowledge bases
4. Split into multiple queries
```

## Model Safety

### Safety Features

| Model | Safety Approach |
|-------|-----------------|
| Claude | Constitutional AI |
| GPT-4 | RLHF, safety training |
| Llama | Safety-tuned versions |

### Avoiding Harmful Outputs

```
Best practices:
1. Use appropriate system prompts
2. Set temperature for consistency
3. Implement output filtering
4. Monitor for jailbreak attempts
```

## Related

- [[01-Introduction]] - AI basics
- [[02-Core-Concepts]] - LLM internals
- [[03-Agents]] - Agent selection
- [[04-Prompting]] - Model-specific prompting
- [[08-Opencode]] - Opencode model selection
