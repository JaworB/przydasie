# AI Agents

Understanding agentic AI systems that can autonomously plan and execute tasks.

## What is an AI Agent?

An AI agent is a system that can:
1. **Perceive** its environment
2. **Reason** about goals and options
3. **Plan** steps to achieve goals
4. **Act** using available tools
5. **Learn** from outcomes

### Agent vs. Assistant

| Assistant | Agent |
|-----------|-------|
| Responds to direct requests | Pursues goals autonomously |
| Single-turn interactions | Multi-step planning |
| Limited context awareness | Environment awareness |
| Example: ChatGPT | Example: Opencode with tools |

## Autonomy Levels

| Level | Description | Example |
|-------|-------------|---------|
| **L0: Reactive** | No memory, single response | Basic chatbot |
| **L1: Conversational** | Maintains conversation context | ChatGPT |
| **L2: Tool-Using** | Can call external tools | Claude with tools |
| **L3: Planning** | Creates multi-step plans | Opencode build agent |
| **L4: Autonomous** | Self-directed goal pursuit | Research agents |

## Agent Architecture

```
┌─────────────────────────────────────────┐
│           Agent System                  │
├─────────────────────────────────────────┤
│  ┌─────────────┐                        │
│  │  Planning   │ ← Goal decomposition  │
│  └──────┬──────┘                        │
│         ↓                               │
│  ┌─────────────┐                        │
│  │ Reasoning   │ ← Chain of Thought     │
│  └──────┬──────┘                        │
│         ↓                               │
│  ┌─────────────┐                        │
│  │   Action    │ ← Tool calls          │
│  │   Taking    │   File operations      │
│  └──────┬──────┘   Commands            │
│         ↓                               │
│  ┌─────────────┐                        │
│  │  Learning   │ ← Feedback loop        │
│  └─────────────┘                        │
└─────────────────────────────────────────┘
         ↓
┌─────────────────────────────────────────┐
│  Tools: bash, read, write, edit, grep   │
└─────────────────────────────────────────┘
```

## Planning

### Goal Decomposition

Breaking complex goals into manageable steps:

```
Goal: "Set up my development environment"

分解 (Breakdown):
1. Check existing tools
2. Install missing dependencies
3. Configure dotfiles
4. Set up workspace
5. Clone repositories
```

### ReAct Pattern

Combine Reasoning and Acting:

```
Thought: I need to understand the codebase structure
Action: Use `find` to list files
Observation: Found main.py, tests/, docs/
Thought: Now I need to check requirements
Action: Read requirements.txt
Observation: Django, pytest, black
...
```

## Multi-Agent Systems

Multiple agents collaborating on complex tasks:

| Agent | Role |
|-------|------|
| **Planner** | Creates overall strategy |
| **Researcher** | Gathers information |
| **Coder** | Writes and edits code |
| **Tester** | Validates changes |
| **Reviewer** | Quality checks |

### Agent Communication

```
Planner → "Build a web app"
  ↓
Coder → Writes code
  ↓
Tester → "Tests passing"
  ↓
Reviewer → "Code looks good"
  ↓
Planner → "Task complete"
```

## Opencode Agents

Opencode provides built-in agents:

| Agent | Purpose | Use When |
|-------|---------|----------|
| **build** | Code generation, refactoring | Writing new code |
| **general** | Q&A, explanation | Understanding concepts |
| **explore** | Codebase analysis | Finding patterns |

**See also:** [[08-Opencode]] for custom agent configuration.

## Tool Use

Agents interact with the world through tools:

| Tool Type | Examples |
|-----------|----------|
| **File Ops** | read, write, edit, glob |
| **Shell** | bash, exec |
| **Search** | grep, codesearch, websearch |
| **Git** | commit, push, branch |

**See also:** [[05-Tools]] for detailed tool documentation.

## Agent Best Practices

### Good Agent Prompts

```
Good:  "Find all Python files that use regex, identify the patterns,
        and summarize what each pattern does"

Bad:   "Check my code"
```

### Agent Safety

| Principle | Description |
|-----------|-------------|
| **Sandboxing** | Limit agent access to sensitive systems |
| **Human-in-loop** | Require approval for destructive actions |
| **Auditing** | Log all agent actions |
| **Scope limiting** | Define clear boundaries |

## Real-World Example

### Opencode Build Agent

```
User: "Create a Python web scraper"

Agent (build):
1. Check existing scrapers in codebase
2. Create scraper.py with requests beautifulsoup
 +3. Add error handling
4. Write tests
5. Run linting
6. Report results
```

## Related

- [[01-Introduction]] - AI basics
- [[04-Prompting]] - Prompting agents effectively
- [[05-Tools]] - Available tools for agents
- [[08-Opencode]] - Extending Opencode agents
