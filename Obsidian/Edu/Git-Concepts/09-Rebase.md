# Interactive Rebase

Rewrite commit history interactively.

## git rebase -i

Start interactive rebase.

```bash
# Start interactive rebase
git rebase -i HEAD~N

# Or from specific commit
git rebase -i abc1234
```

**Commands in interactive mode:**

| Command | Description |
|---------|-------------|
| `pick` | Keep commit as-is |
| `reword` | Change commit message |
| `edit` | Stop at this commit to amend |
| `squash` | Combine with previous commit |
| `fixup` | Like squash but discard message |
| `drop` | Remove commit |
| `exec` | Run shell command |

## Squashing Commits

**Before rebase:**
```
pick Add user model
pick Add login API
pick Fix typo
pick Add logout
```

**After rebase:**
```
pick Add user model
fixup Add login API
fixup Fix typo
pick Add logout
```

**Result:** All combined into one "Add user model" commit

## Reword Commit Message

```
pick a1b2c3d Add user model
reword d4e5f6g Add login API  <-- editor opens, change message
pick g7h8i9j Add logout
```

## Edit Single Commit

```
edit a1b2c3d Add user model
# Git stops at this commit

# Make changes
git add forgotten-file.txt
git commit --amend

# Continue rebase
git rebase --continue
```

## git rebase Options

```bash
# Abort rebase
git rebase --abort

# Skip commit
git rebase --skip

# Continue after conflicts
git rebase --continue

# Rebase onto different base
git rebase --onto new-base old-base branch

# Interactive rebase
git rebase -i HEAD~10
```

## Related

- See [[07-Undo-Fix]] for other ways to modify history
- See [[08-Branching]] for merge strategies
- See [[10-Git-Bisect]] for finding bugs in history

## Next Steps

Proceed to [[10-Git-Bisect]] to learn about binary search for bug finding.
