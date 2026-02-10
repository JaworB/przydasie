# 03-Roles

Roles organize tasks, handlers, variables, and templates into reusable units.

## Role Structure

```
roles/
  role_name/
    tasks/
      main.yml          # Main tasks file
    handlers/
      main.yml          # Main handlers file
    vars/
      main.yml          # Role variables
    defaults/
      main.yml          # Default variables (lowest priority)
    files/
      file.txt          # Static files
    templates/
      template.j2        # Jinja2 templates
    meta/
      main.yml          # Role metadata
```

## Role Directory Purpose

| Directory | Purpose | Priority |
|-----------|---------|----------|
| `tasks/` | Main tasks | - |
| `handlers/` | Handlers | - |
| `vars/` | Variables | High |
| `defaults/` | Default variables | Low |
| `files/` | Static files | - |
| `templates/` | Jinja2 templates | - |
| `meta/` | Dependencies | - |

## Examples from Repository

### Role Usage in Playbook

```yaml
- name: Configure new hosts
  hosts: test
  become: true
  tasks:
    - name: Setup users
      ansible.builtin.include_role:
        name: role_users

    - name: Configure ssh service
      ansible.builtin.include_role:
        name: role_ssh
```

### Role Tasks (role_users/tasks/main.yml)

```yaml
---
- name: Create groups
  ansible.builtin.group:
    name: "{{ item.groups }}"
    state: present
  when: item.groups is defined
  loop: "{{ role_users_user_details }}"

- name: Create users - with password
  ansible.builtin.user:
    name: "{{ item.username }}"
    groups: "{{ item.groups | default('') }}"
    append: true
    create_home: true
    password: "{{ vault_user_password | password_hash('sha512') }}"
  loop: "{{ role_users_user_details }}"
```

### Role Handlers (role_ssh/handlers/main.yml)

```yaml
---
- name: Restart sshd service
  ansible.builtin.service:
    name: sshd
    state: restarted

- name: Restart firewalld service
  ansible.builtin.service:
    name: firewalld
    state: restarted
```

### Role Variables (role_ssh/vars/main.yml)

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

## Importing Roles

```yaml
# Static import (at parse time)
- name: Configure servers
  hosts: all
  roles:
    - role: role_users
    - role: role_ssh
    - role: role_docker
```

```yaml
# Dynamic include (at runtime)
- name: Configure servers
  hosts: all
  tasks:
    - name: Include users role
      ansible.builtin.include_role:
        name: role_users
```

## Related

- [[02-Inventory]] - Previous: Inventory
- [[04-Modules]] - Next: Modules
