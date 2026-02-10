# Ansible Provisioning

This directory contains Ansible playbooks and configuration for provisioning and managing hosts.

## Inventory

The inventory is defined in `inventory.yml` with two groups:

- **test**: Test environment (currently `ubuntu1`)
- **infra**: Infrastructure servers (`bree`, `shire`)

### Host Variables

Host-specific configuration is stored in `host_vars/<hostname>/`:
- `main.yml`: Public variables for the host
- `vault.yml`: Encrypted secrets (requires Ansible Vault password)

### Group Variables

Group-wide variables are in `group_vars/all/`:
- `vault.yml`: Shared secrets for all hosts

## Playbooks

### provisioning.yml

Main playbook for configuring new hosts. Runs on the `test` group and applies the following roles:

1. **role_users** - Setup system users
2. **role_bash** - Configure bash profile
3. **role_ssh** - Configure SSH service (skipped if `role_ssh_skip_task` is defined)
4. **role_wireguard** - Setup WireGuard VPN
5. **role_rsyslog** - Configure logging
6. **role_docker** - Install and configure Docker

## Variables Files

The provisioning playbook requires a `users.yml` file with user configuration. This file is not included in version control.

## Usage

```bash
# Run the provisioning playbook
ansible-playbook provisioning.yml

# Run with specific inventory
ansible-playbook -i inventory.yml provisioning.yml

# Run with vault password file
ansible-playbook provisioning.yml --vault-password-file ~/.vault_pass.txt
```

## Configuration

### WireGuard

WireGuard configuration requires the following variables per host:

**Plaintext variables (can be in host_vars/main.yml):**
- `wireguard_addresses`: List of IP addresses (e.g., `["10.66.66.6/32"]`)
- `wireguard_allowed_ips`: Allowed IP range (e.g., `"10.66.66.0/24"`)

**Encrypted variables (must be in host_vars/<hostname>/vault.yml):**
- `wireguard_endpoint`: VPN endpoint address and port
- `wireguard_private_key`: Host's private key
- `wireguard_public_key`: Peer's public key
- `wireguard_preshared_key`: Pre-shared key for additional security
