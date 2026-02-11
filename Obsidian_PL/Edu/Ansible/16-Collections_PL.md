# 16-Collections

Kolekcje organizują i dystrybuują treść Ansible.

## Struktura kolekcji

```
collections/
  namespace/
    nazwa_kolekcji/
      plugins/
        modules/
          mój_moduł.py
        lookup/
          mój_lookup.py
      roles/
        moja_rola/
      playbooks/
        files/
        templates/
      galaxy.yml
```

## Instaluj kolekcje

### Z Ansible Galaxy

```bash
# Zainstaluj konkretną wersję
ansible-galaxy collection install community.general:8.0.0

# Zainstaluj z pliku wymagań
ansible-galaxy collection install -r requirements.yml
```

### requirements.yml

```yaml
collections:
  - name: community.general
    version: '>=8.0.0'
  - name: amazon.aws
  - name: azure.azure
  - name: google.cloud
```

## Używanie kolekcji

### FQCN (Fully Qualified Collection Name)

```yaml
# Zamiast
- name: Zainstaluj pakiet
  apt:
    name: nginx

# Użyj FQCN
- name: Zainstaluj pakiet
  ansible.builtin.apt:
    name: nginx
```

### Kolekcja w playbooku

```yaml
collections:
  - name: community.general
  - name: amazon.aws

tasks:
  # Używa community.general.ufw
  - name: Zezwól na port
    ufw:
      rule: allow
      port: 80

  # Używa amazon.aws.ec2_instance
  - name: Utwórz instancję EC2
    ec2_instance:
      name: moja-instancja
```

## Przykłady z repozytorium

### requirements.yml

```yaml
---
# Wymagania Ansible Galaxy dla zewnętrznych ról
# Zainstaluj z: ansible-galaxy install -r requirements.yml

roles:
  # Przykład:
  # - src: geerlingguy.docker
  #   version: 4.2.0
  #   name: docker

collections:
  # Przykład:
  # - name: community.general
  #   version: 8.0.0
```

### Używanie kolekcji społeczności

```yaml
# Zapora UFW (community.general)
- name: Zezwól na port SSH w ufw (Debian/Ubuntu)
  community.general.ufw:
    rule: allow
    port: "{{ role_ssh_sshport | default('2229') }}"
    proto: tcp
  when: ansible_os_family == "Debian"

# Port SELinux (community.general)
- name: Dodaj niestandardowy port sshd do SELinux (RedHat)
  community.general.seport:
    ports: "{{ role_ssh_sshport | default('2229') }}"
    proto: tcp
    setype: ssh_port_t
    state: present
  when: ansible_facts.selinux.status is defined and ansible_facts.selinux.status == "enabled"

# Para kluczy OpenSSH (community.crypto)
- name: Generuj klucz SSH na zdalnym hoście
  community.crypto.openssh_keypair:
    path: "/home/{{ item.username }}/.ssh/id_rsa"
    owner: "{{ item.username }}"
    group: "{{ item.username }}"
    mode: '0600'
  loop: "{{ role_users_user_details }}"
```

## Popularne kolekcje

| Kolekcja | Przeznaczenie | Przykładowy moduł |
|------------|---------------|---------------|
| `community.general` | Narzędzia ogólne | ufw, seport, portinstall |
| `community.crypto` | Kryptografia | openssl_*, x509_* |
| `amazon.aws` | Zasoby AWS | ec2_*, s3_* |
| `azure.azure` | Zasoby Azure | azure_rm_* |
| `google.cloud` | Zasoby GCP | gcp_* |
| `netapp.cloudmanager` | NetApp | na_cloudmanager_* |

## Powiązane

- [[15-Delegation_PL]] - Poprzednie: Delegacja
- [[17-Tags_PL]] - Następne: Tagi
