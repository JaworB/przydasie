# Introduction to AI

Understanding artificial intelligence, its types, and how it relates to machine learning.

## What is Artificial Intelligence?

AI refers to systems that can perform tasks that typically require human intelligence:
- **Reasoning** - Drawing conclusions from information
- **Learning** - Improving from experience
- **Problem-solving** - Finding solutions to complex challenges
- **Perception** - Understanding sensory input (text, images, audio)
- **Language** - Understanding and generating human language

## Types of AI

### Narrow AI (Weak AI)

Narrow AI specializes in a specific task:

| Example                | Capability                    |
| ---------------------- | ----------------------------- |
| ChatGPT                | Conversation, text generation |
| Image generators       | Creating images from prompts  |
| Speech recognition     | Converting audio to text      |
| Recommendation systems | Suggesting products/content   |
| Your AI agents         | Task-specific automation      |

**Current state of AI:** We have powerful Narrow AI but no general-purpose artificial intelligence.

### Artificial General Intelligence (AGI)

AGI would be capable of learning any intellectual task that a human can:
- **Not yet achieved** - Despite advances, no system has true general intelligence
- **Ongoing research** - Many believe it's decades away
- **Safety concerns** - AGI development raises significant ethical questions

## Machine Learning Basics

### What is Machine Learning?

ML is a subset of AI where systems learn from data rather than being explicitly programmed:

```
Traditional Programming:  Data + Rules → Output
Machine Learning:         Data + Output → Rules
```

### Types of ML

| Type | Description | Example |
|------|-------------|---------|
| **Supervised Learning** | Learn from labeled data | Spam classification |
| **Unsupervised Learning** | Find patterns in unlabeled data | Customer segmentation |
| **Reinforcement Learning** | Learn from rewards/punishments | Game playing |
| **Deep Learning** | Neural networks with many layers | Image recognition |

### Large Language Models (LLMs)

LLMs are a type of deep learning trained on vast amounts of text:

| Component | Description |
|-----------|-------------|
| **Training** | Learning patterns from internet-scale text |
| **Parameters** | Billions of "weights" that encode knowledge (GPT-4 has ~1.76 trillion) |
| **Inference** | Generating responses to prompts |
| **Fine-tuning** | Adapting models for specific tasks |

## History of AI

| Year | Milestone |
|------|-----------|
| 1950 | Turing Test proposed by Alan Turing |
| 1956 | Dartmouth Conference - AI coined as a field |
| 1966 | ELIZA - First chatbot (pattern matching) |
| 1997 | Deep Blue beats Kasparov at chess |
| 2012 | AlexNet - Deep learning revolution in image recognition |
| 2017 | Transformer architecture introduced (Attention Is All You Need) |
| 2020 | GPT-3 - 175 billion parameters |
| 2022 | ChatGPT launched - Popularized AI assistants |
| 2023 | GPT-4, Claude, Llama - Multimodal models emerge |
| 2024+ | Specialized agents, RAG, enterprise AI |

## Key Terms

| Term | Definition |
|------|------------|
| **Model** | A trained AI system (GPT-4, Claude, Llama) |
| **Inference** | Using a trained model to make predictions |
| **Token** | A unit of text (roughly 4 characters) |
| **Context Window** | Maximum tokens a model can see |
| **Temperature** | Controls randomness in output (0 = deterministic) |
| **Fine-tuning** | Further training on specific data |
| **Prompt** | Input text that guides model output |

## AI in Practice

### Current Applications

| Domain | Example Use |
|--------|-------------|
| **Code** | Code completion, bug fixing, documentation |
| **Writing** | Drafting, editing, translation |
| **Analysis** | Data interpretation, summarization |
| **Automation** | AI agents, workflow automation |
| **Research** | Literature review, hypothesis generation |

### AI for Software Engineering

AI tools are transforming how we build software:
- **Code generation** - Write boilerplate, tests, docs
- **Debugging** - Find and fix errors
- **Refactoring** - Improve code structure
- **Documentation** - Generate and maintain docs
- **Automation** - AI agents for task completion

**See also:** [[08-Opencode]] for extending AI agents for your workflow.

## Related

- [[02-Core-Concepts]] - LLM internals
- [[03-Agents]] - Agentic AI systems
- [[08-Opencode]] - Practical AI agent extension
