# 07-Variables

Variables store data for use in playbooks and templates.

## Variable Types

### Inventory Variables

```yaml
# host_vars/hostname.yml
---
ansible_host: 10.0.0.1
ansible_user: admin
custom_var: value

# group_vars/groupname.yml
---
all_hosts:
  packages:
    - nginx
    - git
```

### Playbook Variables

```yaml
vars:
  app_name: myapp
  app_port: 8080
  enabled: true
```

### vars_files

```yaml
vars_files:
  - users.yml
  - secrets.yml
```

### Role Variables

```yaml
# In playbook
- hosts: all
  roles:
    - role: myrole
      myvar: value

# In role vars/main.yml
---
role_variable: default_value
```

## Variable Sources Priority

| Priority | Source |
|----------|--------|
| 1 | Command line (-e) |
| 2 | Connection variables (ansible_* ) |
| 3 | Facts |
| 4 | Role defaults |
| 5 | Inventory variables |
| 6 | Playbook vars |
| 7 | vars_files |
| 8 | Role variables |
| 9 | Host facts |

## Examples from Repository

### vars_files in Playbook

```yaml
- name: Configure new hosts
  hosts: test
  become: true
  vars_files:
    - users.yml
  tasks:
    - name: Setup users
      ansible.builtin.include_role:
        name: role_users
```

### Host Variables

```yaml
# host_vars/ubuntu1/main.yml
---
wireguard_addresses:
  - "10.66.66.6/32"
wireguard_allowed_ips: "10.66.66.0/24"
```

### Group Variables

```yaml
# group_vars/all/vault.yml
---
vault_user_password: !vault |
  $ANSIBLE_VAULT;1.1;AES256
  66366131306532383032326136623530...
```

## Using Variables

```yaml
# In tasks
- name: Create user
  ansible.builtin.user:
    name: "{{ username }}"
    shell: "{{ shell | default('/bin/bash') }}"

# In templates
{{ variable_name }}

# In conditions
when: ansible_os_family == "Debian"

# In loops
loop: "{{ user_list }}"
```

## Variable Filters

```yaml
# Default value
{{ variable | default('default_value') }}

# Upper/lower case
{{ name | upper }}
{{ name | lower }}

# List filters
{{ list | first }}
{{ list | last }}
{{ list | length }}

# String filters
{{ path | basename }}
{{ url | basename }}

# Password hash
{{ password | password_hash('sha512') }}
```

## Related

- [[06-Loops]] - Previous: Loops
- [[08-Vault]] - Next: Vault
