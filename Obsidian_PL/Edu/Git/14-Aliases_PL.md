# Aliasy

Popularne skróty Git.

## Twórz aliasy

```bash
# Podstawowe aliasy
git config --global alias.st status
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.df diff

# Złożone aliasy
git config --global alias.unstage 'reset HEAD --'
git config --global alias.last 'log -1 HEAD'
git config --global alias.visual '!gitk'

# Alias ładnego logu
git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
```

## Lista użytecznych aliasów

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

## Powiązane

- Zobacz [[16-Cheatsheet_PL]] wszystkie polecenia
- Zobacz [[05-Basic-Workflow_PL]] polecenia przepływu pracy
- Zobacz [[15-Tips-Best-Contents_PL]] rekomendacje

## Następne kroki

Przejdź do [[15-Tips-Best-Practices_PL]] aby dowiedzieć się o najlepszych praktykach.
