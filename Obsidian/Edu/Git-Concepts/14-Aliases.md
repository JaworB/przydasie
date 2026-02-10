# Aliases

Common Git shortcuts.

## Create Aliases

```bash
# Basic aliases
git config --global alias.st status
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.df diff

# Complex aliases
git config --global alias.unstage 'reset HEAD --'
git config --global alias.last 'log -1 HEAD'
git config --global alias.visual '!gitk'

# Pretty log alias
git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
```

## Useful Aliases List

```bash
git config --global alias.st status
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.df diff
git config --global alias.lg "log --oneline --graph"
git config --global alias.unstage 'reset HEAD --'
git config --global alias.undo 'reset --soft HEAD~1'
git config --global alias.cleanup 'branch --merged | grep -v "\*" | xargs -n 1 git branch -d'
```

## Related

- See [[16-Cheatsheet]] for all commands
- See [[05-Basic-Workflow]] for workflow commands
- See [[15-Tips-Best-Practices]] for recommendations

## Next Steps

Proceed to [[15-Tips-Best-Practices]] to learn best practices.
