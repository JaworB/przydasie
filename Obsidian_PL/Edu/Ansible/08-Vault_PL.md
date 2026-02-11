# 08-Vault

Ansible Vault szyfruje wrażliwe dane, takie jak hasła i klucze.

## Utwórz zaszyfrowany plik

```bash
# Interaktywny monit o hasło
ansible-vault create secrets.yml

# Używając pliku haseł
ansible-vault create --vault-password-file .vault_pass secrets.yml

# Używając skryptu haseł
ansible-vault create --vault-password-file vault_pass.py secrets.yml
```

## Zaszyfruj istniejący plik

```bash
ansible-vault encrypt secrets.yml
ansible-vault encrypt --vault-password-file .vault_pass secrets.yml
```

## Odszyfruj plik

```bash
ansible-vault decrypt secrets.yml
ansible-vault decrypt --vault-password-file .vault_pass secrets.yml
```

## Edytuj zaszyfrowany plik

```bash
ansible-vault edit secrets.yml
ansible-vault edit --vault-password-file .vault_pass secrets.yml
```

## Wyświetl zaszyfrowany plik

```bash
ansible-vault view secrets.yml
ansible-vault view --vault-password-file .vault_pass secrets.yml
```

## Zmień hasło vault

```bash
ansible-vault rekey secrets.yml
```

## Przykłady z repozytorium

### Struktura pliku vault

```yaml
---
# Zaszyfrowany vault zawierający wrażliwe zmienne dla wszystkich hostów
# Użyj --vault-password-file do odszyfrowania podczas uruchamiania playbooków
vault_user_password: !vault |
  $ANSIBLE_VAULT;1.1;AES256
  66366131306532383032326136623530636663326639376162326464373131303264613762346365
  3763346134373066643734326562323365323534623138630a323737346532323538343030646234
  37616631623963386666613632336262376165643730353231326539393435333537626234633534
  3030393163323837390a333564363133353565393531643231653264366335323630383733626136
  6233
```

### Używanie zmiennych vault

```yaml
- name: Twórz użytkowników - z hasłem
  ansible.builtin.user:
    name: "{{ item.username }}"
    password: "{{ vault_user_password | password_hash('sha512') }}"
  loop: "{{ role_users_user_details }}"
```

## Uruchamianie z vault

```bash
# Uruchom playbook z plikiem haseł vault
ansible-playbook --vault-password-file ~/.vault_pass provisioning.yml

# Użyj wielu identyfikatorów vault
ansible-playbook --vault-id vault1.yml --vault-id vault2.yml provisioning.yml

# Monituj o hasło
ansible-playbook --ask-vault-pass provisioning.yml

# Sprawdź składnię z vault
ansible-playbook --syntax-check --vault-password-file ~/.vault_pass provisioning.yml
```

## Najlepsze praktyki

1. **Nigdy nie commituj haseł vault** - Użyj `.gitignore`
2. **Używaj plików haseł** - Łatwiejsze do automatyzacji
3. **Używaj osobnych vaultów** - Różne hasła dla dev/prod
4. **Kontrola wersji** - Śledź zaszyfrowane pliki, nie hasła
5. **Rotacja** - Regularnie zmieniaj hasła vault

## .gitignore

```gitignore
*vault*password*
*.vault_pass
.vault_pass.txt
vault_pass.py
```

## Powiązane

- [[07-Variables_PL]] - Poprzednie: Zmienne
- [[09-Templates_PL]] - Następne: Szablony
