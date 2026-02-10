# Stashing

Save changes without committing.

## git stash

Save changes without committing.

```bash
# Save current changes
git stash

# Save with message
git stash save "Work in progress"

# Save untracked stash -u
 files too
gitgit stash --include-untracked
```

## git stash pop

```bash
# Apply last stash and remove it
git stash pop

# Apply specific stash
git stash pop stash@{2}

# Apply without removing
git stash apply
git stash apply stash@{1}
```

## git stash list

```bash
# List all stashes
git stash list

# Show stash contents
git stash show
git stash show -p
```

## git stash drop

```bash
# Remove last stash
git stash drop

# Remove specific stash
git stash drop stash@{2}

# Clear all stashes
git stash clear
```

## Partial Stashing

```bash
# Stash specific files
git stash push path/to/file1 path/to/file2

# Stash interactively
git stash push -p
# Select hunks:
# y - stash this hunk
# n - don't stash this hunk
# q - quit
# a - stash all remaining
```

## Workflow Example

```bash
$ git status
On branch feature/login
Changes to be committed:
  new file:   src/auth.js

Changes not staged for commit:
  modified:   src/config.js

Untracked files:
  debug.log

# Stash everything
$ git stash -u -m "WIP: Authentication feature"

$ git status
On branch feature/login
nothing to commit (clean)

# ... switch to another branch ...
$ git checkout main

# ... do work ...

# ... back to feature ...
$ git checkout feature/login
$ git stash pop
# Changes restored!
```

## Related

- See [[05-Basic-Workflow]] for the normal workflow
- See [[07-Undo-Fix]] for other ways to handle changes
- See [[16-Cheatsheet]] for quick reference

## Next Steps

Proceed to [[12-Remotes]] to learn about remote operations.
