# 10-Handlers

Handlers are tasks that only run when triggered by notifications.

## Handler Syntax

```yaml
handlers:
  - name: Handler name
    module_name:
      option: value
```

## Triggering Handlers

```yaml
- name: Task name
  module_name:
    option: value
  notify: Handler name
```

## Examples from Repository

### Handler Definition (role_ssh/handlers/main.yml)

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

### Triggering Handlers

```yaml
- name: Configure SSHD (Debian/Ubuntu)
  ansible.posix.sshd:
    port: "{{ role_ssh_sshport | default('2229') }}"
    pubkeyauthentication: yes
    passwordauthentication: no
    permitrootlogin: no
  when: ansible_os_family == "Debian"
  notify: Restart sshd service

- name: Configure SSHD (RedHat)
  ansible.posix.sshd:
    port: "{{ role_ssh_sshport | default('2229') }}"
    pubkeyauthentication: yes
    passwordauthentication: no
    permitrootlogin: no
    firewalld: yes
  when: ansible_os_family == "RedHat"
  notify: Restart sshd service
  notify: Restart firewalld service
```

## Handler Execution

Handlers execute:
1. After all tasks complete
2. In the order they were notified
3. Only once even if notified multiple times

## Force Handlers

```bash
ansible-playbook playbook.yml --force-handlers
```

## Listen Topics

```yaml
handlers:
  - name: Restart web services
    listen: web_restart
    service:
      name: nginx
      state: restarted

tasks:
  - name: Config changed
    template:
      src: nginx.conf.j2
      dest: /etc/nginx/nginx.conf
    notify
```

## When: web_restart with Handlers

```yaml
handlers:
  - name: Restart service
    service:
      name: nginx
      state: restarted
    when: nginx_restart_required.stat.exists
```

## Common Handler Types

| Handler | Purpose |
|---------|---------|
| `service` | Restart/stop/start service |
| `systemd` | Systemd service management |
| `command` | Run arbitrary command |
| `file` | Create/modify files |

## Related

- [[09-Templates]] - Previous: Templates
- [[11-Privilege-Escalation]] - Next: Privilege Escalation
