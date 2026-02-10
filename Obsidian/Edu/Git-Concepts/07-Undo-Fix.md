# Undo & Fix

Commands to undo and fix mistakes in Git.

## git restore

Restore files from index or commit.

```bash
# Restore from staging area
git restore --staged path/to/file

# Restore from last commit
git restore path/to/file

# Restore to specific commit
git restore --source=abc1234 path/to/file

# Restore all files
git restore .
```

**Example:**
```bash
$ git status
Changes not staged for commit:
  modified:   src/config.js

$ git restore src/config.js
# File is now back to last committed state
```

## git reset

Move HEAD to a previous commit.

```bash
# Soft reset (keep changes staged)
git reset --soft HEAD~1

# Mixed reset (default, keep changes in working dir)
git reset HEAD~1

# Hard reset (discard all changes)
git reset --hard HEAD~1

# Reset to specific commit
git reset --hard abc1234

# Reset only specific files
git reset HEAD~1 -- path/to/file
```

**Reset types:**
| Type | Changes Staged | Working Dir | History |
|------|----------------|-------------|---------|
| `--soft` | Kept | Kept | Changed |
| `--mixed` | Cleared | Kept | Changed |
| `--hard` | Cleared | Discarded | Changed |

**Reset vs Revert:**

| Reset | Revert |
|-------|--------|
| Rewrites history | Creates new commit |
| Changes commit pointer | Preserves history |
| Dangerous on shared branches | Safe for collaboration |

## git revert

Create new commit that undoes changes.

```bash
# Revert last commit
git revert HEAD

# Revert specific commit
git revert abc1234

# Revert without auto-commit
git revert --no-commit abc1234
git revert --continue

# Revert merge commit
git revert -m 1 abc1234
```

**Example:**
```bash
$ git log --oneline
a1b2c3d Add feature (current)
d4e5f6g Fix bug

$ git revert a1b2c3d
[main f6g7h8i] Revert "Add feature"
```

## git commit --amend

Modify the last commit.

```bash
# Change last commit message
git commit --amend -m "New message"

# Add files to last commit
git add forgotten-file.txt
git commit --amend --no-edit

# Change author
git commit --amend --author="Name <email>"
```

**⚠️ WARNING: Don't amend public commits!**

## git clean

Remove untracked files.

```bash
# Preview what would be deleted
git clean --dry-run
git clean -n

# Remove untracked files
git clean -f

# Remove untracked directories
git clean -fd

# Remove ignored files
git clean -fX

# Remove everything (including ignored)
git clean -fx
```

## Related

- See [[05-Basic-Workflow]] for the standard workflow
- See [[09-Rebase]] for rewriting history interactively
- See [[08-Branching]] for merge operations

## Next Steps

Proceed to [[08-Branching]] to learn about branch management and merging.
