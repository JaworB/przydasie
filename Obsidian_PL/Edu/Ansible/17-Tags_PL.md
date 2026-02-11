# 17-Tags

Tagi umożliwiają selektywne wykonanie części playbooka.

## Składnia tagu

```yaml
- name: Zadanie z tagami
  nazwa_modułu:
    opcja: wartość
  tags:
    - tag1
    - tag2

# Skrót dla pojedynczego tagu
- name: Zadanie
  tags: always
  debug:
    msg: "Zawsze uruchamiane"
```

## Taguj play

```yaml
- name: Play z tagami
  hosts: all
  tags: web
  tasks:
    - name: Zadanie z tagiem
      debug:
        msg: "Zadanie z tagiem"
```

## Taguj rolę

```yaml
- name: Play z oznaczoną rolą
  hosts: all
  roles:
    - role: nginx
      tags: web
```

## Uruchamiaj z tagami

```bash
# Uruchom zadania z tagami
ansible-playbook playbook.yml --tags "web"

# Pomiń zadania z tagami
ansible-playbook playbook.yml --skip-tags "debug"

# Wiele tagów
ansible-playbook playbook.yml --tags "web,db"
ansible-playbook playbook.yml --skip-tags "debug,verbose"

# Wyświetl tagi bez uruchamiania
ansible-playbook playbook.yml --list-tags
```

## Popularne nazwy tagów

| Tag | Przeznaczenie |
|-----|---------------|
| `always` | Zawsze uruchamiaj (chyba że pominięte) |
| `never` | Nigdy nie uruchamiaj (chyba że jawnie oznaczone) |
| `web` | Zadania serwera webowego |
| `db` | Zadania bazy danych |
| `security` | Zadania związane z bezpieczeństwem |
| `config` | Zadania konfiguracyjne |

## Dziedziczenie tagów

Tagi są dziedziczone:
- Tagi play dotyczą wszystkich zadań w play
- Tagi roli dotyczą wszystkich zadań w roli
- Tagi zadania są dodawane do dziedziczonych tagów

## Przykłady

```yaml
- name: Zainstaluj pakiety
  ansible.builtin.apt:
    name: "{{ item }}"
  loop:
    - nginx
    - git
    - vim
  tags:
    - packages
    - web

- name: Konfiguruj nginx
  template:
    src: nginx.conf.j2
    dest: /etc/nginx/nginx.conf
  tags:
    - nginx
    - config
  notify: Restart nginx

- name: Uruchom usługi
  service:
    name: nginx
    state: started
  tags:
    - services
    - web
```

## Powiązane

- [[16-Collections_PL]] - Poprzednie: Kolekcje
- [[18-Blocks_PL]] - Następne: Bloki
