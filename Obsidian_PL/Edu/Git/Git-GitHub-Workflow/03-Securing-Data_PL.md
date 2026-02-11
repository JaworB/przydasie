# Zabezpieczanie danych

Ochrona wrażliwych danych w repozytorium.

## Wzorzec .env

Utwórz plik `.env` z wrażliwymi danymi:

```bash
# .env (NIE commituj!)
API_KEY=sekretny-klucz-api
DATABASE_PASSWORD=hasło-bazy
SECRET_TOKEN=token
```

## .gitignore

```bash
# Dodaj do .gitignore
.env
.env.local
.env.*.local
*.pem
*.key
config/secrets.yml
```

## Używaj zmiennych środowiskowych

```python
# Python
import os
api_key = os.environ.get('API_KEY')

# JavaScript
const apiKey = process.env.API_KEY;
```

## Ansible Vault (dla infrastruktury)

```bash
# Utwórz zaszyfrowany plik
ansible-vault create secrets.yml

# Edytuj
ansible-vault edit secrets.yml
```

## Uprawnienia plików

```bash
# Pliki z kluczami
chmod 600 ~/.ssh/id_ed25519
chmod 644 ~/.ssh/id_ed25519.pub

# Pliki .env
chmod 600 .env
```

## Powiązane

- Zobacz [[04-Removing-Credentials_PL]] usuwanie sekretów z historii
- Zobacz [[02-SSH-Keys_PL]] klucze SSH
- Zobacz [[../Ansible/08-Vault_PL]] Ansible Vault
