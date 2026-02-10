# Branching

Manage branches and merge changes.

## Branching Diagram

```
                    feature/login
                    |
A---B---C---D---E---+---F---G---H  (main)
            \       \
             \       \
              I---J---K---L---M---N  (feature/auth)
```

## git branch

Manage branches.

```bash
# List branches
git branch

# List all branches (including remote)
git branch -a

# List with last commit
git branch -v

# Create new branch
git branch feature/login

# Delete branch
git branch -d feature/login    # Safe delete
git branch -D feature/login    # Force delete

# Rename branch
git branch -m old-name new-name
```

## git checkout / git switch

Switch branches.

```bash
# Switch to existing branch
git checkout feature-branch
git switch feature-branch

# Create and switch
git checkout -b new-branch
git switch -c new-branch

# Switch to previous branch
git checkout -
git switch -

# Detach HEAD (switch to specific commit)
git checkout abc1234

# Force switch
git checkout -f feature-branch
```

**⚠️ WARNING: Uncommitted changes may be lost!**

## git merge

Join branch history.

```bash
# Merge feature into current branch
git merge feature-branch

# Fast-forward merge
git merge feature-branch

# No fast-forward (creates merge commit)
git merge --no-ff feature-branch

# Squash commits
git merge --squash feature-branch
git commit -m "Merge feature"

# Abort merge
git merge --abort
```

## Merge Types

**Fast-forward merge:**
```
Before:                     After:
A---B---C  main             A---B---C---D---E---F  main
        \                                    /
         D---E---F  feature ---------------
```

**No fast-forward merge:**
```
Before:                     After:
A---B---C  main             A---B---C-------G  main
        \                  /         \
         D---E---F  feature           D---E---F  feature
                                    (G = merge commit)
```

## Conflict Resolution

**When conflicts occur:**
```
<<<<<<< HEAD
const name = "Alice";
=======
const name = "Bob";
>>>>>>> feature-branch
```

**Resolution steps:**
```bash
# 1. Open file and fix conflicts
vim path/to/file

# 2. Mark as resolved
git add path/to/file

# 3. Complete merge
git commit
```

## Related

- See [[07-Undo-Fix]] for undoing merges
- See [[09-Rebase]] for alternative to merging
- See [[16-Cheatsheet]] for quick command reference

## Next Steps

Proceed to [[09-Rebase]] to learn about interactive rebasing.
