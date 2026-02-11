# 11-Privilege-Escalation

Become umożliwia uruchamianie zadań z podwyższonymi uprawnieniami (sudo/su).

## Składnia become

```yaml
- name: Zadanie wymagające roota
  become: true
  become_method: sudo
  become_user: root
  nazwa_modułu:
    opcja: wartość
```

## Metody become

| Metoda | Opis |
|--------|------|
| `sudo` | Użyj sudo (domyślne na Linux) |
| `su` | Użyj su |
| `doas` | Użyj doas |
| `pbrun` | PowerBroker run |
| `pmrun` | Privilege Manager run |

## Przykłady z repozytorium

### Become na poziomie playbooka

```yaml
- name: Konfiguruj nowe hosty
  hosts: test
  become: true          # Wszystkie zadania jako root
  become_user: root
  tasks:
    - name: Konfiguruj użytkowników
      ansible.builtin.include_role:
        name: role_users
```

### Become na poziomie zadania

```yaml
- name: Generuj klucz SSH na zdalnym hoście
  remote_user: "{{ item.username }}"
  become: yes
  become_user: "{{ item.username }}"
  community.crypto.openssh_keypair:
    path: "/home/{{ item.username }}/.ssh/id_rsa"
    owner: "{{ item.username }}"
    group: "{{ item.username }}"
    mode: '0600'
  loop: "{{ role_users_user_details }}"
```

## Zmienne become

```yaml
# W inventory lub playbooku
ansible_become: yes
ansible_become_method: sudo
ansible_become_user: root
ansible_become_pass: "{{ vault_become_password }}"
```

## Become w linii poleceń

```bash
# Become jako root
ansible-playbook playbook.yml -b

# Become jako konkretny użytkownik
ansible-playbook playbook.yml -b --become-user admin

# Z monitem o hasło
ansible-playbook playbook.yml -K

# Z plikiem haseł become
ansible-playbook playbook.yml --become-password-file ~/.become_pass
```

## Wymagania uprawnień

### Konfiguracja sudoers

```sudoers
# Pozwól użytkownikowi sudo bez hasła
username ALL=(ALL) NOPASSWD: ALL

# Pozwól na konkretne polecenia
username ALL=(ALL) NOPASSWD: /bin/systemctl, /bin/apt
```

### Become w zadaniach

```yaml
- name: Zainstaluj pakiet
  become: yes
  ansible.builtin.apt:
    name: nginx
    state: present

- name: Twórz użytkownika
  become: yes
  ansible.builtin.user:
    name: nowy_użytkownik
    state: present

- name: Edytuj plik konfiguracyjny
  become: yes
  ansible.builtin.lineinfile:
    dest: /etc/nginx/nginx.conf
    line: "worker_processes auto"
    regexp: "^worker_processes"
    state: present
```

## Powiązane

- [[10-Handlers_PL]] - Poprzednie: Handlery
- [[12-Facts_PL]] - Następne: Fakty
