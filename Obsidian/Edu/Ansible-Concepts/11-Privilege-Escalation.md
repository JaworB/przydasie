# 11-Privilege-Escalation

Become enables running tasks with elevated privileges (sudo/su).

## Become Syntax

```yaml
- name: Task requiring root
  become: true
  become_method: sudo
  become_user: root
  module_name:
    option: value
```

## Become Methods

| Method | Description |
|--------|-------------|
| `sudo` | Use sudo (default on Linux) |
| `su` | Use su |
| `doas` | Use doas |
| `pbrun` | PowerBroker run |
| `pmrun` | Privilege Manager run |

## Examples from Repository

### Playbook Level Become

```yaml
- name: Configure new hosts
  hosts: test
  become: true          # All tasks run as root
  become_user: root
  tasks:
    - name: Setup users
      ansible.builtin.include_role:
        name: role_users
```

### Task Level Become

```yaml
- name: Generate SSH key on remote host
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

## Become Variables

```yaml
# In inventory or playbook
ansible_become: yes
ansible_become_method: sudo
ansible_become_user: root
ansible_become_pass: "{{ vault_become_password }}"
```

## Become on Command Line

```bash
# Become root
ansible-playbook playbook.yml -b

# Become specific user
ansible-playbook playbook.yml -b --become-user admin

# With password prompt
ansible-playbook playbook.yml -K

# With become password file
ansible-playbook playbook.yml --become-password-file ~/.become_pass
```

## Privilege Requirements

### Sudoers Configuration

```sudoers
# Allow user to sudo without password
username ALL=(ALL) NOPASSWD: ALL

# Allow specific commands
username ALL=(ALL) NOPASSWD: /bin/systemctl, /bin/apt
```

### Become in Tasks

```yaml
- name: Install package
  become: yes
  ansible.builtin.apt:
    name: nginx
    state: present

- name: Create user
  become: yes
  ansible.builtin.user:
    name: newuser
    state: present

- name: Edit config file
  become: yes
  ansible.builtin.lineinfile:
    dest: /etc/nginx/nginx.conf
    line: "worker_processes auto"
    regexp: "^worker_processes"
    state: present
```

## Related

- [[10-Handlers]] - Previous: Handlers
- [[12-Facts]] - Next: Facts
