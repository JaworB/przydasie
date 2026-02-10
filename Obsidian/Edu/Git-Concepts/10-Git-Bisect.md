# Git Bisect

Binary search to find the commit that introduced a bug.

## How It Works

```
Search range: 100 commits

Step 1: Test commit 50  -> BAD
Step 2: Test commit 25  -> GOOD
Step 3: Test commit 37  -> BAD
Step 4: Test commit 31  -> GOOD
Step 5: Test commit 34  -> BAD
Found: First bad commit at position 34
```

## Manual Bisect

```bash
# Start bisect
git bisect start

# Mark current commit as bad
git bisect bad

# Mark a known good commit
git bisect good v1.0.0

# Git checks out middle commit
# ... test the code ...

# Mark result
git bisect good    # or git bisect bad

# Repeat until Git finds it

# End bisect
git bisect reset
```

## Automated Bisect

```bash
# Run test script automatically
git bisect start
git bisect bad
git bisect good v1.0.0
git bisect run ./test.sh

# Exit codes:
# 0 = good (pass)
# 1 = bad (fail)
# 125 = skip this commit
```

**Test script example:**
```bash
#!/bin/bash
# test.sh - Run tests and exit with code
npm test
exit $?
```

## Commands Reference

| Command | Description |
|---------|-------------|
| `git bisect start` | Begin bisect session |
| `git bisect bad` | Mark current as bad |
| `git bisect good <commit>` | Mark commit as good |
| `git bisect skip <commit>` | Skip commit |
| `git bisect run <script>` | Automated testing |
| `git bisect reset` | End session |
| `git bisect log` | Show bisect history |

## Example Session

```bash
$ git bisect start
Bisecting: 12 commits left to test after this (roughly 4 steps)

$ git bisect bad
Bisecting: 12 commits left to test (roughly 4 steps)

$ git bisect good v1.0.0
Bisecting: 6 commits left to test (roughly 3 steps)

# Git checks out commit abc1234
# ... run tests ...
$ npm test
Tests failed!

$ git bisect bad
Bisecting: 3 commits left to test (roughly 2 steps)

# Git checks out def5678
# ... run tests ...
$ npm test
Tests passed!

$ git bisect good
abc1234 is the first bad commit
```

## Related

- See [[09-Rebase]] for rewriting history
- See [[06-Inspection]] for viewing commit history
- See [[16-Cheatsheet]] for quick reference

## Next Steps

Proceed to [[11-Stashing]] to learn about saving work in progress.
