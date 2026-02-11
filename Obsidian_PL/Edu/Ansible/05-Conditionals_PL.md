# 05-Conditionals

Warunki kontrolują, kiedy zadania są wykonywane na podstawie zmiennych i faktów.

## Instrukcja when

```yaml
- name: Nazwa zadania
  nazwa_modułu:
    opcja: wartość
  when: warunek
```

## Popularne warunki

| Warunek | Opis |
|----------|------|
| `when: ansible_os_family == "Debian"` | Rodzina OS to Debian/Ubuntu |
| `when: ansible_os_family == "RedHat"` | Rodzina OS to RedHat/CentOS |
| `when: ansible_distribution == "Ubuntu"` | Konkretna dystrybucja |
| `when: ansible_distribution_version == "20.04"` | Konkretna wersja |
| `when: ansible_hostname == "server1"` | Konkretna nazwa hosta |
| `when: result.rc == 0` | Kod powrotu poprzedniego polecenia |

## Przykłady z repozytorium

### Warunki na rodzinę OS

```yaml
- name: Zainstaluj pakiety SSH (Debian/Ubuntu)
  ansible.builtin.apt:
    name: openssh-server
    state: present
  when: ansible_os_family == "Debian"

- name: Zainstaluj pakiety SSH (RedHat)
  ansible.builtin.dnf:
    name: openssh-server
    state: present
  when: ansible_os_family == "RedHat"

- name: Konfiguruj SSHD (Debian/Ubuntu)
  ansible.posix.sshd:
    port: "{{ role_ssh_sshport | default('2229') }}"
    pubkeyauthentication: yes
  when: ansible_os_family == "Debian"
  notify: Restart sshd service
```

### Warunki na zmienne

```yaml
- name: Twórz użytkowników - z hasłem
  ansible.builtin.user:
    name: "{{ item.username }}"
    password: "{{ vault_user_password | password_hash('sha512') }}"
  loop: "{{ role_users_user_details }}"
  when: vault_user_password is defined

- name: Twórz użytkowników - bez hasła (zablokowani)
  ansible.builtin.user:
    name: "{{ item.username }}"
    password: "*"
  loop: "{{ role_users_user_details }}"
  when: vault_user_password is undefined

- name: Konfiguruj usługę ssh
  ansible.builtin.include_role:
    name: role_ssh
  when: role_ssh_skip_task is undefined
```

### Złożone warunki

```yaml
# Warunek AND
when: ansible_os_family == "Debian" and ansible_architecture == "x86_64"

# Warunek OR
when: ansible_os_family == "Debian" or ansible_os_family == "RedHat"

# Warunek NOT
when: not ansible_system == "Windows"

# Kombinacja
when: |
  (ansible_os_family == "Debian" and ansible_architecture == "x86_64") or
  (ansible_os_family == "RedHat" and ansible_distribution_version == "8")
```

## Testy Jinja2

```yaml
# Sprawdź czy zmienna jest zdefiniowana
when: moja_zmienna is defined
when: moja_zmienna is not defined

# Sprawdź czy zmienna jest prawdziwa
when: moja_zmienna | bool
when: moja_zmienna is true

# Sprawdź czy ciąg zawiera
when: "'Ubuntu' in ansible_distribution"

# Sprawdź czy lista zawiera
when: "'web' in group_names"
```

## Powiązane

- [[04-Modules_PL]] - Poprzednie: Moduły
- [[06-Loops_PL]] - Następne: Pętle
