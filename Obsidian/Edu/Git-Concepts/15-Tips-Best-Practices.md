# Tips & Best Practices

Guidelines and recommendations for using Git effectively.

## Commit Guidelines

| Do | Don't |
|-----|-------|
| Write clear, concise messages | Use vague messages like "fix" |
| One logical change per commit | Bundle unrelated changes |
| Use imperative mood | Use past tense |
| Keep subject < 50 characters | Write long subject lines |
| Reference issues (#123) | Don't reference issues |

## Branch Naming

**Conventions:**
```
feature/name          # New feature
bugfix/name           # Bug fix
hotfix/name           # Emergency fix
release/version       # Release preparation
docs/name             # Documentation
refactor/name         # Code restructuring
test/name             # Tests
```

**Examples:**
```
feature/user-authentication
bugfix/login-crash
hotfix/security-patch
release/v1.0.0
docs/update-readme
```

## Workflow Recommendations

**Feature Branch Workflow:**
```
1. Create branch from main
2. Make commits
3. Push to remote
4. Create pull request
5. Review and merge
6. Delete branch
```

## Useful Tips

```bash
# Auto-correct commands
git config --global help.autocorrect 1

# Colored output
git config --global color.ui auto

# Default editor
git config --global core.editor vim

# Line endings
git config --global core.autocrlf input

# Pull strategy
git config --global pull.rebase false  # Merge
git config --global pull.rebase true   # Rebase

# Set default branch
git config --global init.defaultBranch main

# Ignore file mode changes
git config --global core.fileMode false
```

## ⚠️ Important Warnings

| Warning | Prevention |
|---------|------------|
| Force push to shared branch | Never `git push -f` on main/dev |
| Delete unmerged branch | Use `git branch -d` (safe) |
| Commit sensitive data | Use `.gitignore`, `git rm --cached` |
| Lose commits | Don't `git reset --hard` unsaved work |
| Merge conflicts | Pull frequently, rebase often |

## Related

- See [[05-Basic-Workflow]] for commit message format
- See [[08-Branching]] for branch naming
- See [[Git-GitHub-Workflow]] for advanced workflows

## Next Steps

Proceed to [[16-Cheatsheet]] for a quick command reference.
