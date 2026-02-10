# 09-Templates

Jinja2 templates generate configuration files dynamically.

## Template Syntax

```jinja2
# Variable
{{ variable_name }}

# Conditional
{% if condition %}
  Content
{% endif %}

# Loop
{% for item in items %}
  {{ item }}
{% endfor %}

# Comments
{# This is a comment #}
```

## Template Module

```yaml
- name: Copy template
  ansible.builtin.template:
    src: template.j2
    dest: /etc/app.conf
    owner: root
    group: root
    mode: '0644'
    validate: command %s %s
```

## Examples from Repository

### WireGuard Template (wireguard_template.j2)

```jinja2
[Interface]
PrivateKey = {{ wireguard_private_key }}
Address = {{ wireguard_addresses }}
DNS = 10.66.66.1,1.0.0.1

[Peer]
PublicKey = {{ wireguard_public_key }}
PresharedKey = {{ wireguard_preshared_key }}
Endpoint = {{ wireguard_endpoint }}
AllowedIPs = {{ wireguard_allowed_ips }}
PersistentKeepalive = 25
```

### Template Task

```yaml
- name: Copy config template
  ansible.builtin.template:
    src: wireguard_template.j2
    dest: /etc/wireguard/wg0.conf
    mode: '0644'
    owner: root

- name: Copy rsyslog config file
  ansible.builtin.template:
    src: rsyslog_template.j2
    dest: /etc/rsyslog.conf
    mode: '0644'
    owner: root
```

## Template Filters

```jinja2
# Default value
{{ variable | default('value') }}

# Upper/lower
{{ name | upper }}
{{ name | lower }}

# String operations
{{ path | basename }}
{{ url | basename }}
{{ content | trim }}

# List operations
{{ list | join(', ') }}
{{ list | length }}

# JSON/YAML
{{ data | to_json }}
{{ data | to_yaml }}
{{ json_str | from_json }}
```

## Template Tests

```jinja2
{% if ansible_os_family == "Debian" %}
# Debian-specific config
{% endif %}

{% if wireguard_private_key is defined %}
PrivateKey = {{ wireguard_private_key }}
{% endif %}

{% for user in user_list %}
User: {{ user.name }}
{% endfor %}
```

## Template Variables

### Automatic Variables

| Variable | Description |
|----------|-------------|
| `ansible_managed` | Standard header |
| `template_host` | Host that processed template |
| `template_uid` | UID of template owner |
| `template_path` | Path to template |
| `template_fullpath` | Full path to template |
| `template_run_date` | Date template was processed |

## Best Practices

1. **Validate templates** - Use `validate:` option
2. **Set proper permissions** - `mode:`, `owner:`, `group:`
3. **Use descriptive names** - `app_config.j2`, not `conf.j2`
4. **Add headers** - Include ansible_managed comment
5. **Use variables for sensitive data** - Never hardcode passwords

## Related

- [[08-Vault]] - Previous: Vault
- [[10-Handlers]] - Next: Handlers
