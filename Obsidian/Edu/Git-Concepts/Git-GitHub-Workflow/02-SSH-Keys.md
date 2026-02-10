# SSH Keys

Set up SSH keys for GitHub authentication.

## Generate SSH Key

```bash
ssh-keygen -t rsa -b 4096 -C "your_email@example.com" -f ~/.ssh/id_rsa -N ""
```

## Add to SSH Agent

```bash
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa
```

## Add Public Key to GitHub

1. Copy public key: `cat ~/.ssh/id_rsa.pub`
2. Go to: GitHub → Settings → SSH Keys → New SSH Key
3. Paste the key
4. Click "Add SSH key"

## Switch Remote to SSH

```bash
git remote set-url origin git@github.com:username/repository.git
```

## Related

- See [[01-Initial-Setup]] for initial repository setup
- See [[12-Remotes]] for remote operations
- See [[index]] for overview

## Next Steps

Proceed to [[03-Securing-Data]] to learn about securing sensitive data.
