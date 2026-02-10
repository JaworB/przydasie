# 04-Modules

Modules are reusable units of code that perform specific tasks on target hosts.

## Module Categories

### Ansible Builtin Modules

Core modules maintained by Ansible.

```yaml
# File operations
ansible.builtin.file:
  path: /path/to/file
  state: directory

# Package management
ansible.builtin.apt:
  name: nginx
  state: present

ansible.builtin.dnf:
  name: docker-ce
  state: present

# User management
ansible.builtin.user:
  name: username
  state: present

# Service management
ansible.builtin.service:
  name: nginx
  state: started
  enabled: yes
```

### Ansible Posix Modules

Modules for POSIX-specific features.

```yaml
# SSHd configuration
ansible.posix.sshd:
  port: 2229
  pubkeyauthentication: yes
  permitrootlogin: no

# Authorized keys
ansible.posix.authorized_key:
  user: username
  key: "{{ lookup('file', '~/.ssh/id_rsa.pub') }}"
```

### Community Modules

Modules from Ansible Galaxy.

```yaml
# UFW firewall (community.general)
community.general.ufw:
  rule: allow
  port: 2229
  proto: tcp

# SELinux port (community.general)
community.general.seport:
  ports: 2229
  proto: tcp
  setype: ssh_port_t
  state: present

# OpenSSH keypair (community.crypto)
community.crypto.openssh_keypair:
  path: /home/user/.ssh/id_rsa
  owner: user
  group: user
  mode: '0600'
```

## Examples from Repository

### User Management (role_users)

```yaml
- name: Create users - with password
  ansible.builtin.user:
    name: "{{ item.username }}"
    groups: "{{ item.groups | default('') }}"
    append: true
    create_home: true
    password: "{{ vault_user_password | password_hash('sha512') }}"
    password_expire_max: -1
    comment: "Created during provisioning"
  loop: "{{ role_users_user_details }}"
```

### SSH Configuration (role_ssh)

```yaml
- name: Install SSH packages (Debian/Ubuntu)
  ansible.builtin.apt:
    name: openssh-server
    state: present
  when: ansible_os_family == "Debian"

- name: Configure SSHD using dedicated module (Debian/Ubuntu)
  ansible.posix.sshd:
    port: "{{ role_ssh_sshport | default('2229') }}"
    pubkeyauthentication: yes
    passwordauthentication: no
    permitrootlogin: no
  when: ansible_os_family == "Debian"
  notify: Restart sshd service
```

### Docker Setup (role_docker)

```yaml
- name: Add Docker GPG key (Debian/Ubuntu)
  ansible.builtin.apt_key:
    url: https://download.docker.com/linux/debian/gpg
    state: present
  when: ansible_os_family == "Debian"

- name: Add Docker repository (Debian/Ubuntu)
  ansible.builtin.apt_repository:
    repo: "deb [arch={{ ansible_architecture }}] https://download.docker.com/linux/{{ ansible_distribution | lower }} {{ ansible_distribution_release }} stable"
    state: present
  when: ansible_os_family == "Debian"
```

### File Operations

```yaml
- name: Copy bash.profile
  ansible.builtin.copy:
    src: bashrc
    dest: /home/{{ role_users_remote_username }}/.bashrc
    owner: "{{ role_users_remote_username }}"
    mode: '0644'

- name: Generate SSH key on remote host
  community.crypto.openssh_keypair:
    path: "/home/{{ item.username }}/.ssh/id_rsa"
    owner: "{{ item.username }}"
    group: "{{ item.username }}"
    mode: '0600'
  loop: "{{ role_users_user_details }}"

- name: Fetch private keys to controller
  ansible.builtin.fetch:
    src: "/home/{{ item.username }}/.ssh/id_rsa"
    dest: "{{ playbook_dir }}/ssh_keys/{{ inventory_hostname }}/{{ item.username }}"
    flat: yes
    mode: '0600'
  loop: "{{ role_users_user_details }}"
```

## Module Naming Convention

| Type | Namespace | Example |
|------|-----------|---------|
| Builtin | `ansible.builtin` | `ansible.builtin.file` |
| POSIX | `ansible.posix` | `ansible.posix.sshd` |
| AWS | `amazon.aws` | `amazon.aws.ec2` |
| Azure | `azure.azure` | `azure.azcollection.azure_rm_virtualmachine` |
| Community General | `community.general` | `community.general.ufw` |
| Community Crypto | `community.crypto` | `community.crypto.openssh_keypair` |

## Related

- [[03-Roles]] - Previous: Roles
- [[05-Conditionals]] - Next: Conditionals
