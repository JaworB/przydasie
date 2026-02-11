# Tools and Function Calling

How AI systems use tools to interact with the world.

## What Are Tools?

Tools are functions that AI agents can call to take action:

```
AI Agent → Tool Call → Tool Execution → Result → AI Agent
```

## Tool Categories

| Category | Purpose | Examples |
|-----------|---------|----------|
| **File Operations** | Read, write, modify files | read, write, edit, glob |
| **Shell Commands** | Execute terminal commands | bash, exec |
| **Search** | Find information | grep, codesearch, websearch |
| **Git Operations** | Version control | commit, push, branch |
| **Web** | Fetch web content | webfetch |
| **Specialized** | Domain-specific | skill, todowrite |

## Tool Definition

### Tool Schema

```json
{
  "name": "bash",
  "description": "Execute shell commands",
  "parameters": {
    "command": "string",
    "description": "string",
    "timeout": "number (optional)"
  }
}
```

### Tool Result

```json
{
  "success": true,
  "output": "command output",
  "error": null
}
```

## File Operations

### read

Read file contents:

```
Tool: read
Args: { filePath: "/path/to/file" }
Returns: File contents
```

### write

Create or overwrite files:

```
Tool: write
Args: {
  filePath: "/path/to/file",
  content: "file content"
}
Returns: Confirmation
```

### edit

Modify specific parts of files:

```
Tool: edit
Args: {
  filePath: "/path/to/file",
  oldString: "text to replace",
  newString: "replacement text"
}
Returns: Confirmation or error
```

### glob

Find files by pattern:

```
Tool: glob
Args: {
  pattern: "**/*.py",
  path: "/project" (optional)
}
Returns: List of matching files
```

## Shell Commands

### bash

Execute commands with optional timeout:

```json
{
  "command": "ls -la",
  "description": "List files with details",
  "timeout": 30000
}
```

**Best practices:**
- Always include description
- Set appropriate timeout
- Use absolute paths when possible
- Handle errors gracefully

## Search Tools

### grep

Search file contents:

```json
{
  "pattern": "function.*test",
  "path": "/project",
  "include": "*.py"
}
```

### codesearch

Search for programming patterns:

```json
{
  "query": "React useState hook examples",
  "tokensNum": 5000
}
```

### websearch

Web research:

```json
{
  "query": "Python async await best practices 2024",
  "numResults": 5
}
```

## Git Operations

| Tool | Purpose |
|------|---------|
| git status | Check repository state |
| git add | Stage changes |
| git commit | Create commits |
| git push | Push to remote |
| git diff | View changes |

## Tool Composition

Chaining tools for complex tasks:

```
1. glob → Find files
   ↓
2. read → Examine contents
   ↓
3. edit → Modify files
   ↓
4. bash → Run tests
   ↓
5. git commit → Save changes
```

## Error Handling

### Tool Failure

```json
{
  "success": false,
  "error": "File not found",
  "output": null
}
```

### Recovery Strategies

| Error Type | Handling |
|------------|----------|
| File not found | Check path, create if appropriate |
| Permission denied | Check permissions, use sudo |
| Command failed | Retry, check syntax |
| Timeout | Increase timeout, optimize command |

## Best Practices

### Tool Selection

```
Choose the RIGHT tool for the job:

- Read a file? → read
- Create a file? → write
- Modify content? → edit
- Find files? → glob
- Search content? → grep
- Run commands? → bash
```

### Writing Effective Tools

| Principle | Description |
|-----------|-------------|
| Atomic | Do one thing well |
| Documented | Clear description |
| Idempotent | Safe to call multiple times |
| Error-aware | Handle edge cases |

## Tool Security

### Risk Categories

| Risk | Mitigation |
|------|------------|
| Command injection | Sanitize inputs |
| Path traversal | Validate paths |
| Data exposure | Limit output |
| Privilege escalation | Use least privilege |

### Safe Patterns

```bash
# Good: Specific commands
bash({ command: "ls -la /project" })

# Bad: User-controlled commands
bash({ command: user_input })
```

## Opencode Tools

Opencode provides these built-in tools:

| Tool | Description |
|------|-------------|
| bash | Execute shell commands |
| read | Read file contents |
| write | Create/overwrite files |
| edit | Modify file contents |
| glob | Find files by pattern |
| grep | Search file contents |
| codesearch | Search programming patterns |
| websearch | Web research |
| webfetch | Fetch URL content |
| skill | Load skills |
| todowrite | Task management |

**See also:** [[08-Opencode]] for Opencode-specific tool configuration.

## Related

- [[03-Agents]] - How agents use tools
- [[04-Prompting]] - Prompting for tool use
- [[08-Opencode]] - Opencode tools reference
- [[Bash-Scripting-Concepts]] - Scripting for tools
