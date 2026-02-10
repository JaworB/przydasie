# Git & GitHub Workflow

Notes for managing educational repositories on GitHub.

---

## 1. Initial Setup

### Create & Initialize Repository

```bash
cd ~/path/to/your/repository
git init
git add .
git commit -m "Initial commit"
```

### Add Remote (SSH)

```bash
git remote add origin git@github.com:username/repository.git
git branch -M main
git push -u origin main
```

---

## 2. SSH Key Setup

### Generate SSH Key

```bash
ssh-keygen -t rsa -b 4096 -C "your_email@example.com" -f ~/.ssh/id_rsa -N ""
```

### Add to SSH Agent

```bash
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa
```

### Add Public Key to GitHub

1. Copy public key: `cat ~/.ssh/id_rsa.pub`
2. Add at: GitHub → Settings → SSH Keys → New SSH Key

### Switch Remote to SSH

```bash
git remote set-url origin git@github.com:username/repository.git
```

---

## 3. Securing Sensitive Data

### Fix File Permissions (600)

```bash
chmod 600 path/to/vault.yml
chmod 600 path/to/group_vars/all/vault.yml
```

### Environment Variables Pattern

**Create `.env.example`:**
```bash
# Template - copy to .env and fill in real values
SERVICE_PASSWORD=changeme
DATABASE_URL=changeme
API_KEY=changeme
```

**Use in docker-compose.yml:**
```yaml
services:
  app:
    environment:
      - PASSWORD=${SERVICE_PASSWORD}
      - DATABASE_URL=${DATABASE_URL}
```

### .gitignore Entries

```
# Secrets
*.secret
password.yml
*.vault.yml
*.env

# Docker
docker/**/*.env
!docker/**/*.env.example
path/to/your/docker/**/*.env
```

---

## 4. Removing Credentials from Git History

### ⚠️ Important: Always Backup First

```bash
cp -r ~/path/to/repository ~/path/to/repository_backup_$(date +%Y%m%d_%H%M%S)
```

### Filter History with git filter-branch

```bash
cd ~/path/to/your/repository

git filter-branch -f --tree-filter '
if [ -f path/to/sensitive/file.yml ]; then
    sed -i "s/actual_password_1/[REMOVED]/g; s/actual_password_2/[REMOVED]/g; s/email@example.com/[REMOVED]/g" path/to/sensitive/file.yml
fi
' --tag-name-filter cat -- --all

# Clean up
git update-ref -d refs/original/refs/heads/main 2>/dev/null
git reflog expire --expire=now --all
git gc --prune=now --aggressive

# Force push
git push --force origin main
```

### Verify Removal

```bash
git log --all -S "actual_password_to_find"  # Should return nothing
```

---

## 5. Common Commands

| Action | Command |
|--------|---------|
| Check status | `git status` |
| Add changes | `git add .` |
| Commit | `git commit -m "message"` |
| Push | `git push origin main` |
| Force push | `git push --force origin main` |
| Check remote | `git remote -v` |
| Change remote | `git remote set-url origin new_url` |
| View history | `git log --oneline` |
| Search in history | `git log --all -S "search_term"` |

---

## 6. Important Warnings

1. **Force push rewrites history** - Collaborators must re-clone
2. **GitHub cache** - May take hours to update cached views
3. **Credentials in commit messages** - Filter won't remove them
4. **Always backup** before rewriting history

---

## 7. Best Practices

- [ ] Use `.env` files for all secrets
- [ ] Add `.env` to `.gitignore`
- [ ] Create `.env.example` as template
- [ ] Use 600 permissions for vault files
- [ ] Review changes before committing
- [ ] Use SSH instead of HTTPS for authentication

---

## Related

- [[Ansible-Concepts]] - Ansible Vault
- [[Bash-Scripting-Concepts]] - Automation scripts
