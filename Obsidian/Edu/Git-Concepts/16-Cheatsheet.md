# Cheatsheet

Quick Git command reference.

## Setup & Config

| Command | Description |
|---------|-------------|
| `git config --global user.name "Name"` | Set username |
| `git config --global user.email "email"` | Set email |
| `git config --list` | Show all config |

## Getting Started

| Command | Description |
|---------|-------------|
| `git init` | Initialize repository |
| `git clone url` | Clone remote repository |
| `git clone -b branch url` | Clone specific branch |

## Basic Workflow

| Command | Description |
|---------|-------------|
| `git status` | Show working tree status |
| `git add .` | Stage all changes |
| `git add file` | Stage specific file |
| `git commit -m "msg"` | Commit staged changes |
| `git commit -am "msg"` | Stage and commit all |

## Branching

| Command | Description |
|---------|-------------|
| `git branch` | List branches |
| `git branch name` | Create branch |
| `git checkout -b name` | Create and switch |
| `git switch name` | Switch branch |
| `git branch -d name` | Delete branch |

## Merging

| Command | Description |
|---------|-------------|
| `git merge branch` | Merge into current |
| `git merge --no-ff branch` | No fast-forward |
| `git merge --abort` | Abort merge |

## Remote Operations

| Command | Description |
|---------|-------------|
| `git remote -v` | List remotes |
| `git remote add name url` | Add remote |
| `git push origin branch` | Push to remote |
| `git pull` | Fetch and merge |
| `git fetch` | Download objects |
| `git clone url` | Clone repository |

## Inspection

| Command | Description |
|---------|-------------|
| `git log` | Show commit history |
| `git log --oneline` | Compact history |
| `git log --graph` | Visual graph |
| `git diff` | Show changes |
| `git show commit` | Show commit details |
| `git blame file` | Show file authors |

## Undo

| Command | Description |
|---------|-------------|
| `git restore file` | Restore file |
| `git reset --soft HEAD~1` | Undo commit, keep changes |
| `git reset --hard HEAD~1` | Undo commit, discard changes |
| `git revert commit` | Create undo commit |
| `git commit --amend` | Modify last commit |
| `git clean -fd` | Remove untracked |

## Stashing

| Command | Description |
|---------|-------------|
| `git stash` | Save changes |
| `git stash pop` | Apply and remove |
| `git stash apply` | Apply without removing |
| `git stash list` | List stashes |
| `git stash drop` | Remove stash |

## Advanced

| Command | Description |
|---------|-------------|
| `git rebase -i HEAD~N` | Interactive rebase |
| `git bisect start` | Find buggy commit |
| `git tag -a v1.0 -m "msg"` | Create tag |
| `git cherry-pick commit` | Copy commit |

## Related

- See [[01-Introduction]] for Git overview
- See [[05-Basic-Workflow]] for detailed workflow
- See [[15-Tips-Best-Practices]] for recommendations

## Complete Guide

Return to [[index]] for the full Git Concepts guide.
