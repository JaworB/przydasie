# VPS Overview

## System

| Property | Value |
|----------|-------|
| Hostname | jawor.vpn |
| OS | Rocky Linux 9.7 (Blue Onyx) |
| Architecture | x86_64 |
| Hardware | VPS — Korbank datacenter |
| Public IP | yes |
| VPN IP | 10.66.66.1 (server) |
| SSH | `ssh vps` — port 2229, user root |
| Container runtime | Docker 29 |

## SSH Access

```bash
ssh vps   # via ~/.ssh/config → 10.66.66.1:2229, root
```

Note: SSH is hardened via Ansible role (`VPS_ansible_setup/roles/sshd/`).

## Security

Managed via Ansible (`VPS_ansible_setup/`):

| Role | Purpose |
|------|---------|
| sshd | Custom port 2229, key-only auth |
| firewalld | Restrict inbound traffic |
| fail2ban | Brute-force protection |
| selinux | SELinux enforcing |
| kernel_hardening | sysctl hardening |

## Directory Structure

```
/root/
├── docker-compose.yml       # nginx-proxy-manager
├── pihole/
│   ├── docker-compose.yml   # pihole
│   └── etc-pihole/          # pihole persistent data
├── kontenery/
│   └── nginx/               # nginx-proxy-manager data + certs
└── repos/przydasie/         # repo clone (backup compose, edu, scripts)
```

## Pi-hole

DNS server for the VPN network (`10.66.66.1:53`).
Web UI accessible at `http://10.66.66.1:85` from within VPN.
Password stored in `.env` (not tracked in git).

## nginx-proxy-manager

Reverse proxy for services exposed publicly.
Admin UI at `http://10.66.66.1:81` (VPN only).
