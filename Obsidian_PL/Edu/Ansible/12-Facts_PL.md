# 12-Facts

Fakty to informacje o systemie zbierane przez Ansible przed wykonaniem zadań.

## Zbieranie faktów

```yaml
- name: Playbook
  hosts: all
  gather_facts: true  # Włącz zbieranie faktów (domyślne)
  tasks:
    - name: Zadanie
      debug:
        msg: "{{ ansible_hostname }}"
```

## Wyłącz fakty

```yaml
- name: Playbook bez faktów
  hosts: localhost
  gather_facts: false
  tasks:
    - name: Zadanie
      debug:
        msg: "Brak zebranych faktów"
```

## Popularne fakty

### Fakty systemowe

```yaml
# Nazwa hosta
ansible_hostname
ansible_fqdn

# Informacje o OS
ansible_os_family         # "Debian", "RedHat"
ansible_distribution       # "Ubuntu", "CentOS"
ansible_distribution_version  # "20.04", "8"
ansible_distribution_release  # "focal", "8"

# Architektura
ansible_architecture       # "x86_64"
ansible_processor_vcpus    # Liczba CPU
ansible_memtotal_mb       # Całkowita pamięć w MB
ansible_memfree_mb        # Wolna pamięć w MB

# Sieć
ansible_default_ipv4.address    # Domyślny IP
ansible_eth0.ipv4.address       # IP eth0
ansible_hostname                # Krótka nazwa hosta
```

### Fakty sieciowe

```yaml
ansible_interfaces         # Lista interfejsów
ansible_dns.nameservers    # Serwery DNS
ansible_domain             # Domena DNS
ansible_fqdn               # Pełna nazwa domenowa
```

### Fakty SELinux

```yaml
ansible_facts.selinux.status    # "enabled", "disabled"
ansible_facts.selinux.mode      # "enforcing", "permissive", "disabled"
```

## Przykłady z repozytorium

### Fakty rodziny OS

```yaml
- name: Zainstaluj pakiety SSH (Debian/Ubuntu)
  ansible.builtin.apt:
   -server
    state: present
  name: openssh when: ansible_os_family == "Debian"

- name: Zainstaluj pakiety SSH (RedHat)
  ansible.builtin.dnf:
    name: openssh-server
    state: present
  when: ansible_os_family == "RedHat"
```

### Fakty SELinux

```yaml
- name: Dodaj niestandardowy port sshd do SELinux (RedHat)
  community.general.seport:
    ports: "{{ role_ssh_sshport | default('2229') }}"
    proto: tcp
    setype: ssh_port_t
    state: present
  when: ansible_facts.selinux.status is defined and ansible_facts.selinux.status == "enabled"
```

## Fakty w warunkach

```yaml
# Rodzina OS
when: ansible_os_family == "Debian"

# Dystrybucja
when: ansible_distribution == "Ubuntu"
when: ansible_distribution_version == "20.04"

# Architektura
when: ansible_architecture == "x86_64"

# Pamięć
when: ansible_memtotal_mb > 2048

# Niestandardowe grupy faktów
when: "'webserver' in group_names"
```

## Moduł setup

```yaml
- name: Zbieraj fakty z filtrem
  setup:
    gather_subset:
      - all
      - "!min"  # Wyklucz minimalne fakty
    filter:
      - "ansible_hostname"
      - "ansible_os_*"
```

## Powiązane

- [[11-Privilege-Escalation_PL]] - Poprzednie: Eskalacja uprawnień
- [[13-Lookups_PL]] - Następne: Lookupy
