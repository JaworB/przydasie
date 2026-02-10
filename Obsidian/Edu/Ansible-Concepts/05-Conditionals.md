# 05-Conditionals

Conditionals control when tasks execute based on variables and facts.

## When Statement

```yaml
- name: Task name
  module_name:
    option: value
  when: condition
```

## Common Conditions

| Condition | Description |
|-----------|-------------|
| `when: ansible_os_family == "Debian"` | OS family is Debian/Ubuntu |
| `when: ansible_os_family == "RedHat"` | OS family is RedHat/CentOS |
| `when: ansible_distribution == "Ubuntu"` | Specific distribution |
| `when: ansible_distribution_version == "20.04"` | Specific version |
| `when: ansible_hostname == "server1"` | Specific hostname |
| `when: result.rc == 0` | Previous command return code |

## Examples from Repository

### OS Family Conditionals

```yaml
- name: Install SSH packages (Debian/Ubuntu)
  ansible.builtin.apt:
    name: openssh-server
    state: present
  when: ansible_os_family == "Debian"

- name: Install SSH packages (RedHat)
  ansible.builtin.dnf:
    name: openssh-server
    state: present
  when: ansible_os_family == "RedHat"

- name: Configure SSHD (Debian/Ubuntu)
  ansible.posix.sshd:
    port: "{{ role_ssh_sshport | default('2229') }}"
    pubkeyauthentication: yes
  when: ansible_os_family == "Debian"
  notify: Restart sshd service
```

### Variable Conditionals

```yaml
- name: Create users - with password
  ansible.builtin.user:
    name: "{{ item.username }}"
    password: "{{ vault_user_password | password_hash('sha512') }}"
  loop: "{{ role_users_user_details }}"
  when: vault_user_password is defined

- name: Create users - without password (locked)
  ansible.builtin.user:
    name: "{{ item.username }}"
    password: "*"
  loop: "{{ role_users_user_details }}"
  when: vault_user_password is undefined

- name: Configure ssh service
  ansible.builtin.include_role:
    name: role_ssh
  when: role_ssh_skip_task is undefined
```

### Complex Conditions

```yaml
# AND condition
when: ansible_os_family == "Debian" and ansible_architecture == "x86_64"

# OR condition
when: ansible_os_family == "Debian" or ansible_os_family == "RedHat"

# NOT condition
when: not ansible_system == "Windows"

# Combination
when: |
  (ansible_os_family == "Debian" and ansible_architecture == "x86_64") or
  (ansible_os_family == "RedHat" and ansible_distribution_version == "8")
```

## Jinja2 Tests

```yaml
# Check if variable is defined
when: my_var is defined
when: my_var is not defined

# Check if variable is true
when: my_var | bool
when: my_var is true

# Check if string contains
when: "'Ubuntu' in ansible_distribution"

# Check if list contains
when: "'web' in group_names"
```

## Related

- [[04-Modules]] - Previous: Modules
- [[06-Loops]] - Next: Loops
