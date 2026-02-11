# 03-Roles

Role organizują zadania, handlery, zmienne i szablony w jednostki wielokrotnego użytku.

## Struktura roli

```
roles/
  nazwa_roli/
    tasks/
      main.yml          # Główny plik zadań
    handlers/
      main.yml          # Główny plik handlerów
    vars/
      main.yml          # Zmienne roli
    defaults/
      main.yml          # Zmienne domyślne (najniższy priorytet)
    files/
      plik.txt          # Pliki statyczne
    templates/
      szablon.j2        # Szablony Jinja2
    meta/
      main.yml          # Metadane roli
```

## Przeznaczenie katalogów roli

| Katalog | Przeznaczenie | Priorytet |
|---------|---------------|-----------|
| `tasks/` | Główne zadania | - |
| `handlers/` | Handlery | - |
| `vars/` | Zmienne | Wysoki |
| `defaults/` | Zmienne domyślne | Niski |
| `files/` | Pliki statyczne | - |
| `templates/` | Szablony Jinja2 | - |
| `meta/` | Zależności | - |

## Przykłady z repozytorium

### Użycie roli w playbooku

```yaml
- name: Konfiguruj nowe hosty
  hosts: test
  become: true
  tasks:
    - name: Konfiguruj użytkowników
      ansible.builtin.include_role:
        name: role_users

    - name: Konfiguruj usługę ssh
      ansible.builtin.include_role:
        name: role_ssh
```

### Zadania roli (role_users/tasks/main.yml)

```yaml
---
- name: Twórz grupy
  ansible.builtin.group:
    name: "{{ item.groups }}"
    state: present
  when: item.groups is defined
  loop: "{{ role_users_user_details }}"

- name: Twórz użytkowników - z hasłem
  ansible.builtin.user:
    name: "{{ item.username }}"
    groups: "{{ item.groups | default('') }}"
    append: true
    create_home: true
    password: "{{ vault_user_password | password_hash('sha512') }}"
  loop: "{{ role_users_user_details }}"
```

### Handlery roli (role_ssh/handlers/main.yml)

```yaml
---
- name: Restart usługi sshd
  ansible.builtin.service:
    name: sshd
    state: restarted

- name: Restart usługi firewalld
  ansible.builtin.service:
    name: firewalld
    state: restarted
```

### Zmienne roli (role_ssh/vars/main.yml)

```yaml
role_ssh_rbpi_packages:
  - ssh
  - firewalld
role_ssh_rhel_packages:
  - firewalld
  - openssh
role_ssh_ubuntu_packages:
  - ssh
  - firewalld
```

## Importowanie ról

```yaml
# Statyczny import (w czasie parsowania)
- name: Konfiguruj serwery
  hosts: all
  roles:
    - role: role_users
    - role: role_ssh
    - role: role_docker
```

```yaml
# Dynamiczny include (w czasie wykonania)
- name: Konfiguruj serwery
  hosts: all
  tasks:
    - name: Dołącz rolę użytkowników
      ansible.builtin.include_role:
        name: role_users
```

## Powiązane

- [[02-Inventory_PL]] - Poprzednie: Inventory
- [[04-Modules_PL]] - Następne: Moduły
