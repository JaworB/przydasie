# Basic Workflow

The fundamental Git workflow: status, add, commit.

## git status

Show working tree status.

```bash
# Show full status
git status

# Short format
git status -s

# Show branch info
git status -b

# Show untracked files
git status -u

# Example output (full):
On branch main
Your branch is up to date with 'origin/main'.

Changes not staged for commit:
  modified:   src/index.js
  deleted:     lib/utils.py

Untracked files:
  new-feature/
```

**Status codes (-s):**
```
 M  - Modified in working dir, staged in index
M   - Modified in index, staged in working dir
??  - Untracked
A   - Added to index
D   - Deleted from index
```

## git add

Add changes to staging area.

```bash
# Stage specific file
git add path/to/file.txt

# Stage all changes
git add .

# Stage all changes (recursive)
git add -A

# Stage new and modified files (not deleted)
git add --update

# Interactive staging
git add -i

# Stage portions of files
git add -p

# Dry run
git add --dry-run path/
```

**Example:**
```bash
$ git add src/app.js lib/utils.py
$ git status
Changes to be committed:
  new file:   src/app.js
  modified:   lib/utils.py
```

## git commit

Commit staged changes.

```bash
# Commit with message
git commit -m "Add user authentication"

# Commit with multi-line message
git commit -m "Title" -m "Body description"

# Amend last commit
git commit --amend

# Amend without changing message
git commit --amend --no-edit

# Commit as different author
git commit --author="Name <email>"

# Change commit date
git commit --date="2024-01-15"

# Skip hooks
git commit --no-verify

# Show diff in message editor
git commit -v
```

## Commit Message Best Practices

**Structure:**
```
type(scope): subject

body (optional)

footer (optional)
```

**Types:**
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation
- `style`: Formatting
- `refactor`: Restructuring
- `test`: Testing
- `chore`: Maintenance

**Example:**
```
feat(auth): Add JWT token authentication

Implement JWT-based authentication for API endpoints.

Closes #123
Reviewed-by: @team-lead
```

## Related

- See [[06-Inspection]] for viewing commit history
- See [[07-Undo-Fix]] for fixing mistakes
- See [[02-Core-Concepts]] for understanding the staging area

## Next Steps

Proceed to [[06-Inspection]] to learn how to view and inspect your repository history.
