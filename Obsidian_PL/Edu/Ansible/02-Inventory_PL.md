# 02-Inventory

Inventory definiuje docelowe hosty i grupy dla automatyzacji Ansible.

## Format INI

```ini
[nazwa_grupy]
host1 ansible_host=192.168.1.1 ansible_port=22
host2 ansible_host=192.168.1.2 ansible_user=admin

[all:vars]
ansible_connection=ssh
```

## Format YAML

```yaml
all:
  children:
    grupa1:
      hosts:
        host1:
          ansible_host: 192.168.1.1
        host2:
          ansible_host: 192.168.1.2
    grupa2:
      hosts:
        host3:
          ansible_host: 192.168.1.3
```

## Przykłady z repozytorium

### Inventory z grupami

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

## Zmienne hosta

```yaml
host1:
  ansible_host: 10.0.0.1
  ansible_user: admin
  ansible_port: 2222
  niestandardowa_zmienna: wartość
```

## Zmienne grupy

```yaml
all:
  children:
    serwery_webowe:
      vars:
        nginx_port: 80
        ssl_enabled: true
```

## Specjalne grupy

| Grupa | Cel |
|-------|-----|
| `all` | Zawiera wszystkie hosty |
| `ungrouped` | Hosty nie w żadnej grupie |
| `localhost` | Localhost automatycznie włączony |

## Zmienne Ansible

| Zmienna | Cel | Przykład |
|---------|-----|----------|
| `ansible_host` | IP/nazwa hosta do połączenia | `10.0.0.1` |
| `ansible_port` | Port SSH | `2222` |
| `ansible_user` | Nazwa użytkownika | `admin` |
| `ansible_connection` | Typ połączenia | `ssh`, `local` |
| `ansible_become` | Become sudo | `yes`/`no` |

## Powiązane

- [[01-Playbooks_PL]] - Poprzednie: Playbooki
- [[03-Roles_PL]] - Następne: Role
