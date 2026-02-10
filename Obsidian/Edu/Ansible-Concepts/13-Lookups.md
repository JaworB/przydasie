# 13-Lookups

Lookups retrieve data from external sources.

## Lookup Syntax

```yaml
{{ lookup('plugin_name', 'argument') }}
```

## Built-in Lookups

### File Lookup

```yaml
# Read file contents
{{ lookup('file', '~/.ssh/id_rsa.pub') }}

# In task
- name: Authorize admin pubkey
  ansible.posix.authorized_key:
    user: "{{ item.username }}"
    state: present
    key: "{{ lookup('file', 'files/main.pub') }}"
  loop: "{{ role_users_user_details }}"
```

### Template Lookup

```yaml
# Read template file
{{ lookup('template', 'config.j2') }}
```

### Password Lookup

```yaml
# Generate random password
{{ lookup('password', '/dev/null length=32 chars=ascii_letters,digits') }}

# Use existing password file
{{ lookup('password', 'secrets/password.txt') }}
```

### CSV Lookup

```yaml
# Read CSV file
{{ lookup('csvfile', 'file=users.csv delimiter=, col=1') }}
```

### Ini Lookup

```yaml
# Read INI file
{{ lookup('ini', 'section=value file=app.ini') }}
```

### DNS Lookup

```yaml
# DNS records
{{ lookup('dnstxt', 'example.com') }}
```

### Env Lookup

```yaml
# Environment variable
{{ lookup('env', 'HOME') }}
```

### Pipeline Lookup

```yaml
# Pipe through command
{{ lookup('pipe', 'date +%Y-%m-%d') }}
```

## Template Lookup in Tasks

```yaml
- name: Read SSH public key
  debug:
    msg: "{{ lookup('file', 'files/main.pub') }}"

- name: Authorize keys
  ansible.posix.authorized_key:
    user: admin
    state: present
    key: "{{ lookup('file', 'files/main.pub') }}"
```

## Password Lookup

```yaml
- name: Generate random password
  debug:
    msg: "{{ lookup('password', '/dev/null length=16 chars=ascii_letters,digits') }}"

- name: Create user with password
  ansible.builtin.user:
    name: testuser
    password: "{{ lookup('password', '/dev/null length=16') | password_hash('sha512') }}"
```

## Env Lookup

```yaml
- name: Use environment variable
  debug:
    msg: "Home directory: {{ lookup('env', 'HOME') }}"
```

## Related

- [[12-Facts]] - Previous: Facts
- [[14-Filters]] - Next: Filters
