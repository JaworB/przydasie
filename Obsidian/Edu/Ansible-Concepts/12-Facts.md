# 12-Facts

Facts are system information collected by Ansible before executing tasks.

## Gather Facts

```yaml
- name: Playbook
  hosts: all
  gather_facts: true  # Enable fact gathering (default)
  tasks:
    - name: Task
      debug:
        msg: "{{ ansible_hostname }}"
```

## Disable Facts

```yaml
- name: Playbook without facts
  hosts: localhost
  gather_facts: false
  tasks:
    - name: Task
      debug:
        msg: "No facts gathered"
```

## Common Facts

### System Facts

```yaml
# Hostname
ansible_hostname
ansible_fqdn

# OS Information
ansible_os_family         # "Debian", "RedHat"
ansible_distribution       # "Ubuntu", "CentOS"
ansible_distribution_version  # "20.04", "8"
ansible_distribution_release  # "focal", "8"

# Architecture
ansible_architecture       # "x86_64"
ansible_processor_vcpus    # Number of CPUs
ansible_memtotal_mb       # Total memory in MB
ansible_memfree_mb        # Free memory in MB

# Network
ansible_default_ipv4.address    # Default IP
ansible_eth0.ipv4.address       # eth0 IP
ansible_hostname                # Short hostname
```

### Network Facts

```yaml
ansible_interfaces         # List of interfaces
ansible_dns.nameservers    # DNS servers
ansible_domain             # DNS domain
ansible_fqdn               # Fully qualified domain name
```

### SELinux Facts

```yaml
ansible_facts.selinux.status    # "enabled", "disabled"
ansible_facts.selinux.mode      # "enforcing", "permissive", "disabled"
```

## Examples from Repository

### OS Family Facts

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
```

### SELinux Facts

```yaml
- name: Add custom sshd port to SELinux (RedHat)
  community.general.seport:
    ports: "{{ role_ssh_sshport | default('2229') }}"
    proto: tcp
    setype: ssh_port_t
    state: present
  when: ansible_facts.selinux.status is defined and ansible_facts.selinux.status == "enabled"
```

## Facts in Conditions

```yaml
# OS family
when: ansible_os_family == "Debian"

# Distribution
when: ansible_distribution == "Ubuntu"
when: ansible_distribution_version == "20.04"

# Architecture
when: ansible_architecture == "x86_64"

# Memory
when: ansible_memtotal_mb > 2048

# Custom fact groups
when: "'webserver' in group_names"
```

## Setup Module

```yaml
- name: Gather facts with filter
  setup:
    gather_subset:
      - all
      - "!min"  # Exclude min facts
    filter:
      - "ansible_hostname"
      - "ansible_os_*"
```

## Related

- [[11-Privilege-Escalation]] - Previous: Privilege Escalation
- [[13-Lookups]] - Next: Lookups
