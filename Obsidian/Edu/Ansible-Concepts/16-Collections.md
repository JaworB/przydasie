# 16-Collections

Collections organize and distribute Ansible content.

## Collection Structure

```
collections/
  namespace/
    collection_name/
      plugins/
        modules/
          my_module.py
        lookup/
          my_lookup.py
      roles/
        myrole/
      playbooks/
        files/
        templates/
      galaxy.yml
```

## Install Collections

### From Ansible Galaxy

```bash
# Install specific version
ansible-galaxy collection install community.general:8.0.0

# Install from requirements file
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

## Use Collections

### FQCN (Fully Qualified Collection Name)

```yaml
# Instead of
- name: Install package
  apt:
    name: nginx

# Use FQCN
- name: Install package
  ansible.builtin.apt:
    name: nginx
```

### Collection in Playbook

```yaml
collections:
  - name: community.general
  - name: amazon.aws

tasks:
  # Uses community.general.ufw
  - name: Allow port
    ufw:
      rule: allow
      port: 80

  # Uses amazon.aws.ec2_instance
  - name: Create EC2 instance
    ec2_instance:
      name: my-instance
```

## Examples from Repository

### requirements.yml

```yaml
---
# Ansible Galaxy requirements for external roles
# Install with: ansible-galaxy install -r requirements.yml

roles:
  # Example:
  # - src: geerlingguy.docker
  #   version: 4.2.0
  #   name: docker

collections:
  # Example:
  # - name: community.general
  #   version: 8.0.0
```

### Using Community Collections

```yaml
# UFW firewall (community.general)
- name: Allow SSH port in ufw (Debian/Ubuntu)
  community.general.ufw:
    rule: allow
    port: "{{ role_ssh_sshport | default('2229') }}"
    proto: tcp
  when: ansible_os_family == "Debian"

# SELinux port (community.general)
- name: Add custom sshd port to SELinux (RedHat)
  community.general.seport:
    ports: "{{ role_ssh_sshport | default('2229') }}"
    proto: tcp
    setype: ssh_port_t
    state: present
  when: ansible_facts.selinux.status is defined and ansible_facts.selinux.status == "enabled"

# OpenSSH keypair (community.crypto)
- name: Generate SSH key on remote host
  community.crypto.openssh_keypair:
    path: "/home/{{ item.username }}/.ssh/id_rsa"
    owner: "{{ item.username }}"
    group: "{{ item.username }}"
    mode: '0600'
  loop: "{{ role_users_user_details }}"
```

## Common Collections

| Collection | Purpose | Example Module |
|------------|---------|---------------|
| `community.general` | General utilities | ufw, seport, portinstall |
| `community.crypto` | Cryptography | openssl_*, x509_* |
| `amazon.aws` | AWS resources | ec2_*, s3_* |
| `azure.azure` | Azure resources | azure_rm_* |
| `google.cloud` | GCP resources | gcp_* |
| `netapp.cloudmanager` | NetApp | na_cloudmanager_* |

## Related

- [[15-Delegation]] - Previous: Delegation
- [[17-Tags]] - Next: Tags
