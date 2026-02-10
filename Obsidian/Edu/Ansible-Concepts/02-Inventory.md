# 02-Inventory

Inventory defines target hosts and groups for Ansible automation.

## INI Format

```ini
[group_name]
host1 ansible_host=192.168.1.1 ansible_port=22
host2 ansible_host=192.168.1.2 ansible_user=admin

[all:vars]
ansible_connection=ssh
```

## YAML Format

```yaml
all:
  children:
    group1:
      hosts:
        host1:
          ansible_host: 192.168.1.1
        host2:
          ansible_host: 192.168.1.2
    group2:
      hosts:
        host3:
          ansible_host: 192.168.1.3
```

## Examples from Repository

### Inventory with Groups

```yaml
test:
  hosts:
    ubuntu1:
      ansible_user: ansible_user

infra:
  hosts:
    bree:
      ansible_port: 2229
      ansible_host: 10.66.66.2
    shire:
      ansible_port: 22
      ansible_host: 10.66.66.3
```

## Host Variables

```yaml
host1:
  ansible_host: 10.0.0.1
  ansible_user: admin
  ansible_port: 2222
  custom_var: value
```

## Group Variables

```yaml
all:
  children:
    web_servers:
      vars:
        nginx_port: 80
        ssl_enabled: true
```

## Special Groups

| Group | Purpose |
|-------|---------|
| `all` | Contains all hosts |
| `ungrouped` | Hosts not in any group |
| `localhost` | Localhost automatically included |

## Ansible Variables

| Variable | Purpose | Example |
|----------|---------|---------|
| `ansible_host` | IP/hostname to connect | `10.0.0.1` |
| `ansible_port` | SSH port | `2222` |
| `ansible_user` | Username to connect as | `admin` |
| `ansible_connection` | Connection type | `ssh`, `local` |
| `ansible_become` | Become sudo | `yes`/`no` |

## Related

- [[01-Playbooks]] - Previous: Playbooks
- [[03-Roles]] - Next: Roles
