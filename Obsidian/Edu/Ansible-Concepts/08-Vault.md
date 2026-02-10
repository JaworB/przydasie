# 08-Vault

Ansible Vault encrypts sensitive data like passwords and keys.

## Create Encrypted File

```bash
# Interactive password prompt
ansible-vault create secrets.yml

# Using password file
ansible-vault create --vault-password-file .vault_pass secrets.yml

# Using password script
ansible-vault create --vault-password-file vault_pass.py secrets.yml
```

## Encrypt Existing File

```bash
ansible-vault encrypt secrets.yml
ansible-vault encrypt --vault-password-file .vault_pass secrets.yml
```

## Decrypt File

```bash
ansible-vault decrypt secrets.yml
ansible-vault decrypt --vault-password-file .vault_pass secrets.yml
```

## Edit Encrypted File

```bash
ansible-vault edit secrets.yml
ansible-vault edit --vault-password-file .vault_pass secrets.yml
```

## View Encrypted File

```bash
ansible-vault view secrets.yml
ansible-vault view --vault-password-file .vault_pass secrets.yml
```

## Rekey Vault Password

```bash
ansible-vault rekey secrets.yml
```

## Examples from Repository

### Vault File Structure

```yaml
---
# Encrypted vault containing sensitive variables for all hosts
# Use --vault-password-file to decrypt when running playbooks
vault_user_password: !vault |
  $ANSIBLE_VAULT;1.1;AES256
  66366131306532383032326136623530636663326639376162326464373131303264613762346365
  3763346134373066643734326562323365323534623138630a323737346532323538343030646234
  37616631623963386666613632336262376165643730353231326539393435333537626234633534
  3030393163323837390a333564363133353564393531643231653264366335323630383733626136
  6233
```

### Using Vault Variables

```yaml
- name: Create users - with password
  ansible.builtin.user:
    name: "{{ item.username }}"
    password: "{{ vault_user_password | password_hash('sha512') }}"
  loop: "{{ role_users_user_details }}"
```

## Running with Vault

```bash
# Run playbook with vault password file
ansible-playbook --vault-password-file ~/.vault_pass provisioning.yml

# Use multiple vault IDs
ansible-playbook --vault-id vault1.yml --vault-id vault2.yml provisioning.yml

# Prompt for password
ansible-playbook --ask-vault-pass provisioning.yml

# Check syntax with vault
ansible-playbook --syntax-check --vault-password-file ~/.vault_pass provisioning.yml
```

## Best Practices

1. **Never commit vault passwords** - Use `.gitignore`
2. **Use password files** - Easier for automation
3. **Use separate vaults** - Different passwords for dev/prod
4. **Version control** - Track encrypted files, not passwords
5. **Rotation** - Regularly rotate vault passwords

## .gitignore

```gitignore
*vault*password*
*.vault_pass
.vault_pass.txt
vault_pass.py
```

## Related

- [[07-Variables]] - Previous: Variables
- [[09-Templates]] - Next: Templates
