# Remote Operations

Work with remote repositories.

## git remote

Manage remote repositories.

```bash
# List remotes
git remote -v

# Add remote
git remote add origin git@github.com:user/repo.git

# Rename remote
git remote rename origin upstream

# Remove remote
git remote remove origin

# Change remote URL
git remote set-url origin new-url

# Show remote details
git remote show origin
```

## git push

Send commits to remote.

```bash
# Push to remote
git push origin main

# Set upstream and push
git push -u origin feature-branch

# Push all branches
git push --all origin

# Push tags
git push origin v1.0.0
git push --tags

# Delete remote branch
git push origin --delete feature-branch

# Force push
git push --force

# ⚠️ WARNING: Never force push to main!
```

## git fetch

Download objects without merging.

```bash
# Fetch from all remotes
git fetch

# Fetch from specific remote
git fetch origin

# Fetch and prune
git fetch --prune

# Fetch with tags
git fetch --tags
```

## git pull

Fetch and merge.

```bash
# Pull (fetch + merge)
git pull origin main

# Pull with rebase
git pull --rebase origin main

# Pull and abort on conflicts
git pull --abort
```

## git clone

Copy remote repository.

```bash
# Clone via SSH
git clone git@github.com:user/repo.git

# Clone via HTTPS
git clone https://github.com/user/repo.git

# Shallow clone
git clone --depth 1 url
```

## Remote Workflow Diagram

```
Local Repo                    Remote Repo (origin)
     |                              |
     |   git push                   |
     |----------------------------->|  Push commits
     |                              |
     |   git fetch                  |
     |<-----------------------------|  Download objects
     |                              |
     |   git merge                  |
     |   (in .git/refs/heads/)     |
     |                              |
```

## Related

- See [[04-Getting-Started]] for init and clone
- See [[08-Branching]] for branch operations
- See [[Git-GitHub-Workflow]] for GitHub-specific workflows

## Next Steps

Proceed to [[13-Tags]] to learn about tagging commits.
