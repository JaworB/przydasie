# 14-Filters

Jinja2 filters transform data within templates and variables.

## Filter Syntax

```yaml
{{ variable | filter_name }}
{{ variable | filter_name(param) }}
```

## String Filters

```yaml
# Upper/lower case
{{ name | upper }}      # "HELLO"
{{ name | lower }}      # "hello"

# Capitalize
{{ name | capitalize }}  # "Hello"

# Title case
{{ name | title }}      # "Hello World"

# Trim whitespace
{{ name | trim }}       # "no spaces"
{{ name | lstrip }}     # Trim left
{{ name | rstrip }}     # Trim right

# Replace
{{ name | replace('old', 'new') }}
```

## Default Filter

```yaml
# With default
{{ variable | default('value') }}
{{ variable | default(false) }}  # Preserve falsy values

# Nested default
{{ some.nested.var | default('value') }}
```

## Number Filters

```yaml
# Convert to integer
{{ '42' | int }}

# Convert to float
{{ '3.14' | float }}

# Round numbers
{{ 3.14159 | round(2) }}     # 3.14

# Min/max
{{ [1, 2, 3] | min }}        # 1
{{ [1, 2, 3] | max }}        # 3

# Sum
{{ [1, 2, 3] | sum }}        # 6
```

## List Filters

```yaml
# First/last
{{ [1, 2, 3] | first }}      # 1
{{ [1, 2, 3] | last }}       # 3

# Length
{{ list | length }}

# Sort
{{ [3, 1, 2] | sort }}        # [1, 2, 3]

# Unique
{{ [1, 2, 2, 3] | unique }}  # [1, 2, 3]

# Join
{{ ['a', 'b', 'c'] | join(', ') }}  # "a, b, c"

# Map
{{ users | map(attribute='name') | list }}

# Select
{{ numbers | select("even") | list }}
```

## Path Filters

```yaml
# Basename
{{ path | basename }}  # "file.txt"

# Dirname
{{ path | dirname }}   # "/path/to"

# Realpath
{{ path | realpath }}

# Expand user
{{ path | expanduser }}
```

## Data Conversion Filters

```yaml
# To JSON
{{ data | to_json }}    # {"key": "value"}
{{ data | to_nice_json }}

# To YAML
{{ data | to_yaml }}
{{ data | to_nice_yaml }}

# From JSON/YAML
{{ json_str | from_json }}
{{ yaml_str | from_yaml }}

# To boolean
{{ 'yes' | bool }}
{{ 1 | bool }}
```

## Password Hash Filter

```yaml
# Hash password
{{ password | password_hash('sha512') }}
{{ password | password_hash('sha256') }}
{{ password | password_hash('md5') }}
```

## Examples from Repository

### Default Filter

```yaml
- name: Create users
  ansible.builtin.user:
    name: "{{ item.username }}"
    groups: "{{ item.groups | default('') }}"  # Use empty string if undefined
    append: true
```

### Default with Port

```yaml
- name: Configure SSHD
  ansible.posix.sshd:
    port: "{{ role_ssh_sshport | default('2229') }}"  # Default to 2229
```

### Password Hash Filter

```yaml
- name: Create users - with password
  ansible.builtin.user:
    name: "{{ item.username }}"
    password: "{{ vault_user_password | password_hash('sha512') }}"
  loop: "{{ role_users_user_details }}"
```

## Related

- [[13-Lookups]] - Previous: Lookups
- [[15-Delegation]] - Next: Delegation
