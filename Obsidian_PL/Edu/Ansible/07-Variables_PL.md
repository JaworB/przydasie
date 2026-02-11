# 07-Variables

Zmienne przechowują dane do użycia w playbookach i szablonach.

## Typy zmiennych

### Zmienne inventory

```yaml
# host_vars/nazwa_hosta.yml
---
ansible_host: 10.0.0.1
ansible_user: admin
niestandardowa_zmienna: wartość

# group_vars/nazwa_grupy.yml
---
wszystkie_hosty:
  pakiety:
    - nginx
    - git
```

### Zmienne playbooka

```yaml
vars:
  nazwa_aplikacji: moja_aplikacja
  port_aplikacji: 8080
  włączone: true
```

### vars_files

```yaml
vars_files:
  - users.yml
  - secrets.yml
```

### Zmienne roli

```yaml
# W playbooku
- hosts: all
  roles:
    - role: moja_rola
      moja_zmienna: wartość

# W vars/main.yml roli
---
zmienna_roli: wartość_domyślna
```

## Priorytet źródeł zmiennych

| Priorytet | Źródło |
|-----------|---------|
| 1 | Linia poleceń (-e) |
| 2 | Zmienne połączenia (ansible_*) |
| 3 | Fakty |
| 4 | Domyślne wartości roli |
| 5 | Zmienne inventory |
| 6 | Zmienne playbooka |
| 7 | vars_files |
| 8 | Zmienne roli |
| 9 | Fakty hostów |

## Przykłady z repozytorium

### vars_files w playbooku

```yaml
- name: Konfiguruj nowe hosty
  hosts: test
  become: true
  vars_files:
    - users.yml
  tasks:
    - name: Konfiguruj użytkowników
      ansible.builtin.include_role:
        name: role_users
```

### Zmienne hosta

```yaml
# host_vars/ubuntu1/main.yml
---
wireguard_addresses:
  - "10.66.66.6/32"
wireguard_allowed_ips: "10.66.66.0/24"
```

### Zmienne grupy

```yaml
# group_vars/all/vault.yml
---
vault_user_password: !vault |
  $ANSIBLE_VAULT;1.1;AES256
  66366131306532383032326136623530...
```

## Używanie zmiennych

```yaml
# W zadaniach
- name: Twórz użytkownika
  ansible.builtin.user:
    name: "{{ nazwa_użytkownika }}"
    shell: "{{ powłoka | default('/bin/bash') }}"

# W szablonach
{{ nazwa_zmiennej }}

# W warunkach
when: ansible_os_family == "Debian"

# W pętlach
loop: "{{ lista_użytkowników }}"
```

## Filtry zmiennych

```yaml
# Wartość domyślna
{{ zmienna | default('wartość_domyślna') }}

# Duże/małe litery
{{ nazwa | upper }}
{{ nazwa | lower }}

# Filtry list
{{ lista | first }}
{{ lista | last }}
{{ lista | length }}

# Filtry ciągów
{{ ścieżka | basename }}
{{ url | basename }}

# Hasło hash
{{ hasło | password_hash('sha512') }}
```

## Powiązane

- [[06-Loops_PL]] - Poprzednie: Pętle
- [[08-Vault_PL]] - Następne: Vault
