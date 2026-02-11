# 10-Handlers

Handlery to zadania, które uruchamiają się tylko po otrzymaniu powiadomienia.

## Składnia handlera

```yaml
handlers:
  - name: Nazwa handlera
    nazwa_modułu:
      opcja: wartość
```

## Wyzwalanie handlerów

```yaml
- name: Nazwa zadania
  nazwa_modułu:
    opcja: wartość
  notify: Nazwa handlera
```

## Przykłady z repozytorium

### Definicja handlerów (role_ssh/handlers/main.yml)

```yaml
---
- name: Restart usługi sshd
  ansible.builtin.service:
    name: sshd
    state: restarted

- name: Restart usługi firewalld
  ansible.builtin.service:
    name: firewalld
    state: restarted
```

### Wyzwalanie handlerów

```yaml
- name: Konfiguruj SSHD (Debian/Ubuntu)
  ansible.posix.sshd:
    port: "{{ role_ssh_sshport | default('2229') }}"
    pubkeyauthentication: yes
    passwordauthentication: no
    permitrootlogin: no
  when: ansible_os_family == "Debian"
  notify: Restart sshd service

- name: Konfiguruj SSHD (RedHat)
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

## Wykonywanie handlerów

Handlery wykonują się:
1. Po zakończeniu wszystkich zadań
2. W kolejności, w jakiej zostały powiadomione
3. Tylko raz, nawet jeśli powiadomione wielokrotnie

## Wymuś handlery

```bash
ansible-playbook playbook.yml --force-handlers
```

## Tematy nasłuchiwania

```yaml
handlers:
  - name: Restart usług webowych
    listen: web_restart
    service:
      name: nginx
      state: restarted

tasks:
  - name: Konfiguracja zmieniona
    template:
      src: nginx.conf.j2
      dest: /etc/nginx/nginx.conf
    notify: web_restart
```

## When z handlerami

```yaml
handlers:
  - name: Restart usługi
    service:
      name: nginx
      state: restarted
    when: nginx_restart_required.stat.exists
```

## Popularne typy handlerów

| Handler | Przeznaczenie |
|---------|---------------|
| `service` | Restart/stop/start usługi |
| `systemd` | Zarządzanie usługami Systemd |
| `command` | Uruchom dowolne polecenie |
| `file` | Twórz/modyfikuj pliki |

## Powiązane

- [[09-Templates_PL]] - Poprzednie: Szablony
- [[11-Privilege-Escalation_PL]] - Następne: Eskalacja uprawnień
