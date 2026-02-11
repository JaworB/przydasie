# 04-Modules

Moduły to jednostki kodu wielokrotnego użytku, które wykonują konkretne zadania na docelowych hostach.

## Kategorie modułów

### Wbudowane moduły Ansible

Moduły podstawowe utrzymywane przez Ansible.

```yaml
# Operacje na plikach
ansible.builtin.file:
  path: /sciezka/do/pliku
  state: directory

# Zarządzanie pakietami
ansible.builtin.apt:
  name: nginx
  state: present

ansible.builtin.dnf:
  name: docker-ce
  state: present

# Zarządzanie użytkownikami
ansible.builtin.user:
  name: nazwa_użytkownika
  state: present

# Zarządzanie usługami
ansible.builtin.service:
  name: nginx
  state: started
  enabled: yes
```

### Moduły Ansible Posix

Moduły dla funkcji specyficznych dla POSIX.

```yaml
# Konfiguracja SSHd
ansible.posix.sshd:
  port: 2229
  pubkeyauthentication: yes
  permitrootlogin: no

# Klucze autoryzowane
ansible.posix.authorized_key:
  user: nazwa_użytkownika
  key: "{{ lookup('file', '~/.ssh/id_rsa.pub') }}"
```

### Moduły społeczności

Moduły z Ansible Galaxy.

```yaml
# Zapora UFW (community.general)
community.general.ufw:
  rule: allow
  port: 2229
  proto: tcp

# Port SELinux (community.general)
community.general.seport:
  ports: 2229
  proto: tcp
  setype: ssh_port_t
  state: present

# Para kluczy OpenSSH (community.crypto)
community.crypto.openssh_keypair:
  path: /home/użytkownik/.ssh/id_rsa
  owner: użytkownik
  group: użytkownik
  mode: '0600'
```

## Przykłady z repozytorium

### Zarządzanie użytkownikami (role_users)

```yaml
- name: Twórz użytkowników - z hasłem
  ansible.builtin.user:
    name: "{{ item.username }}"
    groups: "{{ item.groups | default('') }}"
    append: true
    create_home: true
    password: "{{ vault_user_password | password_hash('sha512') }}"
    password_expire_max: -1
    comment: "Utworzono podczas provisioningu"
  loop: "{{ role_users_user_details }}"
```

### Konfiguracja SSH (role_ssh)

```yaml
- name: Zainstaluj pakiety SSH (Debian/Ubuntu)
  ansible.builtin.apt:
    name: openssh-server
    state: present
  when: ansible_os_family == "Debian"

- name: Konfiguruj SSHD używając dedykowanego modułu (Debian/Ubuntu)
  ansible.posix.sshd:
    port: "{{ role_ssh_sshport | default('2229') }}"
    pubkeyauthentication: yes
    passwordauthentication: no
    permitrootlogin: no
  when: ansible_os_family == "Debian"
  notify: Restart sshd service
```

### Konfiguracja Docker (role_docker)

```yaml
- name: Dodaj klucz GPG Docker (Debian/Ubuntu)
  ansible.builtin.apt_key:
    url: https://download.docker.com/linux/debian/gpg
    state: present
  when: ansible_os_family == "Debian"

- name: Dodaj repozytorium Docker (Debian/Ubuntu)
  ansible.builtin.apt_repository:
    repo: "deb [arch={{ ansible_architecture }}] https://download.docker.com/linux/{{ ansible_distribution | lower }} {{ ansible_distribution_release }} stable"
    state: present
  when: ansible_os_family == "Debian"
```

### Operacje na plikach

```yaml
- name: Kopiuj bash.profile
  ansible.builtin.copy:
    src: bashrc
    dest: /home/{{ role_users_remote_username }}/.bashrc
    owner: "{{ role_users_remote_username }}"
    mode: '0644'

- name: Generuj klucz SSH na zdalnym hoście
  community.crypto.openssh_keypair:
    path: "/home/{{ item.username }}/.ssh/id_rsa"
    owner: "{{ item.username }}"
    group: "{{ item.username }}"
    mode: '0600'
  loop: "{{ role_users_user_details }}"

- name: Pobierz klucze prywatne na kontroler
  ansible.builtin.fetch:
    src: "/home/{{ item.username }}/.ssh/id_rsa"
    dest: "{{ playbook_dir }}/ssh_keys/{{ inventory_hostname }}/{{ item.username }}"
    flat: yes
    mode: '0600'
  loop: "{{ role_users_user_details }}"
```

## Konwencja nazewnictwa modułów

| Typ | Przestrzeń nazw | Przykład |
|-----|-----------------|----------|
| Wbudowany | `ansible.builtin` | `ansible.builtin.file` |
| POSIX | `ansible.posix` | `ansible.posix.sshd` |
| AWS | `amazon.aws` | `amazon.aws.ec2` |
| Azure | `azure.azure` | `azure.azcollection.azure_rm_virtualmachine` |
| Społeczność General | `community.general` | `community.general.ufw` |
| Społeczność Crypto | `community.crypto` | `community.crypto.openssh_keypair` |

## Powiązane

- [[03-Roles_PL]] - Poprzednie: Role
- [[05-Conditionals_PL]] - Następne: Warunki
