# Prompt Engineering

Techniques for crafting effective prompts that get better AI responses.

## Prompt Basics

A prompt is the input that guides AI output:

```
Prompt Quality → Response Quality

Vague:     "Help me with code"
Specific:  "Write a Python function that validates email addresses
            using regex, with unit tests"
```

## Prompt Structure

```
┌────────────────────────────────────────────┐
│ SYSTEM MESSAGE                             │
│ (Role, behavior, constraints)              │
├────────────────────────────────────────────┤
│ CONTEXT                                    │
│ (Background information)                    │
├────────────────────────────────────────────┤
│ TASK                                       │
│ (What to do)                               │
├────────────────────────────────────────────┤
│ CONSTRAINTS                                │
│ (Format, length, style)                    │
├────────────────────────────────────────────┤
│ EXAMPLES                                   │
│ (Few-shot examples)                        │
└────────────────────────────────────────────┘
```

## Prompting Techniques

### Zero-Shot Prompting

No examples, direct request:

```
Prompt: "Classify this sentiment: I love this product"
Output: "Positive"
```

### Few-Shot Prompting

Examples included:

```
Prompt: """
Sentiment examples:
"This is amazing!" → Positive
"This is terrible." → Negative
"I don't know how I feel about this." → Neutral
"Great value for money!" →
Output: "Positive"
```

### Chain-of-Thought (CoT)

Encourage step-by-step reasoning:

```
Prompt: """
Q: If I have 3 apples and buy 5 more, then give 2 to my friend,
   how many do I have?

Let's think step by step:
1. Starting with 3 apples
2. Buy 5 more: 3 + 5 = 8
3. Give 2 away: 8 - 2 = 6

Answer: 6
"""
```

### ReAct (Reason + Act)

Combine reasoning with tool use:

```
Thought: I need to find the file structure
Action: Use `find` to locate Python files
Observation: Found 15 .py files
Thought: Now I need to understand the main entry point
Action: Read main.py
...
```

## Prompt Templates

### Code Generation

```markdown
You are an expert {language} developer.

Task: Write a {function_type} function

Requirements:
- Function name: {name}
- Input: {input_type}
- Output: {output_type}
- Include error handling
- Follow {style_guide}

Return only the code, no explanations.
```

### Code Review

```markdown
You are a senior code reviewer.

Review the following code for:
- Bugs and security issues
- Performance problems
- Code style violations
- Missing tests

Code:
```{language}
{code}
```

Format your review as:
## Issues Found
- [severity] {description}

## Recommendations
- {suggestion}
```

### Documentation

```markdown
You are a technical writer.

Task: Document the following code

Requirements:
- Explain purpose in 2 sentences
- Document all parameters
- Include usage examples
- Explain return values

Code:
```{language}
{code}
```
```

## Iterative Prompting

Improve results through refinement:

```
1. Initial Prompt: "Write a Python function"
   ↓
2. Add constraints: "Add type hints and error handling"
   ↓
3. Specify format: "Use dataclass, follow PEP 8"
   ↓
4. Final version optimized
```

## Common Mistakes

| Mistake | Better Approach |
|---------|-----------------|
| Too vague | Be specific about input/output |
| No constraints | Define format, length, style |
| Too many tasks | One task per prompt |
| No examples | Include few-shot examples |
| Ambiguous role | Define system role clearly |

## Prompt Engineering for Code

### Code Writing

```
Good: "Create a Python function to read CSV files with:
       - pandas
       - Type hints (pd.DataFrame) -> dict
       - Handle missing values
       - Return column types"

Bad: "Write code to read CSV"
```

### Debugging

```
"Debug this Python code:

```python
{code}
```

Error: {error}

Explain the cause and suggest a fix."
```

### Explaining Code

```
"Explain this code to a beginner:

```python
{code}
```

Use simple terms, avoid jargon, give examples."
```

## Prompt Optimization

### Token Efficiency

| Approach | Tokens | Quality |
|----------|--------|---------|
| Verbose explanation | High | Same |
| Concise, specific | Low | Same |

### Context Management

```
For long context:
1. Summarize background
2. Focus on relevant details
3. Use explicit section markers
```

## Advanced Techniques

### Persona Prompting

```markdown
You are {persona}.

{persona_description}

Respond in the style of {persona}.
```

### Constraint Programming

```markdown
Constraints:
- Maximum {n} lines
- Use only standard library
- No external dependencies
- Must pass {test_suite}
```

### Format Control

```markdown
Output format: JSON

{
  "function_name": "",
  "parameters": [{"name": "", "type": ""}],
  "return_type": "",
  "description": ""
}
```

## Related

- [[01-Introduction]] - AI basics
- [[02-Core-Concepts]] - Understanding models
- [[03-Agents]] - Prompting agents
- [[08-Opencode]] - Opencode prompt patterns
