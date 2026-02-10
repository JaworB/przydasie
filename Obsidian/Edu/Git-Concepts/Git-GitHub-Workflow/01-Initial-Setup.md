# Initial Setup

Create and initialize a repository on GitHub.

## Create Repository on GitHub

1. Go to https://github.com/new
2. Enter repository name
3. Choose visibility (Public/Private)
4. Don't initialize with README (repo exists locally)
5. Click "Create repository"

## Create & Initialize Repository

```bash
cd ~/path/to/your/repository
git init
git add .
git commit -m "Initial commit"
```

## Add Remote (SSH)

```bash
git remote add origin git@github.com:username/repository.git
git branch -M main
git push -u origin main
```

## Related

- See [[02-SSH-Keys]] for SSH setup
- See [[12-Remotes]] for remote operations
- See [[index]] for overview

## Next Steps

Proceed to [[02-SSH-Keys]] to set up SSH authentication.
