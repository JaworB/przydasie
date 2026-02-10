# Securing Sensitive Data

Protect secrets in your repository.

## Fix File Permissions (600)

```bash
chmod 600 path/to/vault.yml
chmod 600 path/to/group_vars/all/vault.yml
```

## Environment Variables Pattern

### Create .env.example

```bash
# Template - copy to .env and fill in real values
SERVICE_PASSWORD=changeme
DATABASE_URL=changeme
API_KEY=changeme
```

### Use in docker-compose.yml

```yaml
services:
  app:
    environment:
      - PASSWORD=${SERVICE_PASSWORD}
      - DATABASE_URL=${DATABASE_URL}
```

## .gitignore Entries

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

## Related

- See [[04-Removing-Credentials]] for cleaning history
- See [[07-Best-Practices]] for recommendations
- See [[08-Vault]] in [[Ansible-Concepts]] for Ansible Vault

## Next Steps

Proceed to [[04-Removing-Credentials]] to clean exposed credentials.
