# 01-Playbooks

Playbooks are YAML files that define Ansible automation tasks.

## Structure

```yaml
---
- name: Playbook name
  hosts: target_hosts
  become: true
  gather_facts: true
  vars_files:
    - vars_file.yml
  tasks:
    - name: Task name
      module_name:
        option1: value1
        option2: value2
  handlers:
    - name: Handler name
      module_name:
        option: value
```

## Examples from Repository

### Main Provisioning Playbook

```yaml
---
- name: Configure new hosts
  hosts: test
  become: true
  become_user: root
  vars_files:
    - users.yml
  tasks:
    - name: Setup users
      ansible.builtin.include_role:
        name: role_users

    - name: Setup bash profile
      ansible.builtin.include_role:
        name: role_bash

    - name: Configure ssh service
      ansible.builtin.include_role:
        name: role_ssh
      when: role_ssh_skip_task is undefined

    - name: Setup wireguard
      ansible.builtin.include_role:
        name: role_wireguard

    - name: Configure logs
      ansible.builtin.include_role:
        name: role_rsyslog

    - name: Install docker service
      ansible.builtin.include_role:
        name: role_docker
```

### Simple Ping Playbook

```yaml
---
- name: Pingbonk
  hosts: all
  gather_facts: true
  tasks:
    - name: Boink
      ansible.builtin.ping:
```

## Key Attributes

| Attribute | Purpose |
|-----------|---------|
| `name` | Human-readable description |
| `hosts` | Target hosts from inventory |
| `become` | Enable privilege escalation |
| `gather_facts` | Collect system information |
| `vars_files` | Load external variables |
| `tasks` | List of tasks to execute |
| `handlers` | Handlers triggered by tasks |

## Execution

```bash
# Run entire playbook
ansible-playbook provisioning.yml

# Check syntax
ansible-playbook --syntax-check provisioning.yml

# Run with specific inventory
ansible-playbook -i inventory.yml provisioning.yml

# Limit to specific hosts
ansible-playbook --limit ubuntu1 provisioning.yml

# Run with vault password
ansible-playbook --vault-password-file ~/.vault_pass.txt provisioning.yml
```

## Related

- [[02-Inventory]] - Next: Inventory
