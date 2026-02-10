# Removing Credentials

Remove sensitive data from git history.

## ⚠️ Important: Always Backup First

```bash
cp -r ~/path/to/repository ~/path/to/repository_backup_$(date +%Y%m%d_%H%M%S)
```

## Filter History with git filter-branch

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

## Verify Removal

```bash
git log --all -S "actual_password_to_find"  # Should return nothing
```

## Related

- See [[03-Securing-Data]] for prevention
- See [[05-Commands]] for related commands
- See [[index]] for overview

## Next Steps

Proceed to [[05-Commands]] for common command reference.
