# 01-Playbooks

Playbooki to pliki YAML definiujące zadania automatyzacji Ansible.

## Struktura---
- name:

```yaml
 Nazwa playbooka
  hosts: docelowe_hosts
  become: true
  gather_facts: true
  vars_files:
    - plik_zmiennych.yml
  tasks:
    - name: Nazwa zadania
      nazwa_modułu:
        opcja1: wartość1
        opcja2: wartość2
  handlers:
    - name: Nazwa handlera
      nazwa_modułu:
        opcja: wartość
```

## Przykłady z repozytorium

### Główny playbook provisioningu

```yaml
---
- name: Konfiguruj nowe hosty
  hosts: test
  become: true
  become_user: root
  vars_files:
    - users.yml
  tasks:
    - name: Konfiguruj użytkowników
      ansible.builtin.include_role:
        name: role_users

    - name: Konfiguruj profil bash
      ansible.builtin.include_role:
        name: role_bash

    - name: Konfiguruj usługę ssh
      ansible.builtin.include_role:
        name: role_ssh
      when: role_ssh_skip_task is undefined

    - name: Konfiguruj wireguard
      ansible.builtin.include_role:
        name: role_wireguard

    - name: Konfiguruj logi
      ansible.builtin.include_role:
        name: role_rsyslog

    - name: Zainstaluj usługę docker
      ansible.builtin.include_role:
        name: role_docker
```

### Prosty playbook ping

```yaml
---
- name: Pingbonk
  hosts: all
  gather_facts: true
  tasks:
    - name: Boink
      ansible.builtin.ping:
```

## Kluczowe atrybuty

| Atrybut | Cel |
|---------|-----|
| `name` | Czytelny opis |
| `hosts` | Docelowe hosty z inventory |
| `become` | Włącz eskalację uprawnień |
| `gather_facts` | Zbieraj informacje o systemie |
| `vars_files` | Ładuj zewnętrzne zmienne |
| `tasks` | Lista zadań do wykonania |
| `handlers` | Handlery wyzwalane przez zadania |

## Wykonanie

```bash
# Uruchom cały playbook
ansible-playbook provisioning.yml

# Sprawdź składnię
ansible-playbook --syntax-check provisioning.yml

# Uruchom z konkretnym inventory
ansible-playbook -i inventory.yml provisioning.yml

# Ogranicz do konkretnych hostów
ansible-playbook --limit ubuntu1 provisioning.yml

# Uruchom z hasłem vault
ansible-playbook --vault-password-file ~/.vault_pass provisioning.yml
```

## Powiązane

- [[02-Inventory_PL]] - Następne: Inventory
