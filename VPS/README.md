# VPS Ansible Playbook

Konfiguracja VPS Rocky Linux 9 z bootstrap, sshd hardening, firewall, fail2ban i WireGuard.

## Struktura

```
VPS/
├── inventory-centos8.yml  # Inventory hosts
├── site-centos8.yml       # Playbook
├── ansible.cfg            # Ansible config
├── group_vars/
│   └── all.yml            # Zmienne
└── roles/
    ├── bootstrap/         # Zmiana hasła + klucz SSH
    ├── sshd/              # Konfiguracja SSH (port 2229, hardening)
    ├── selinux/           # SELinux permissive
    ├── kernel_hardening/  # sysctl + wyłączenie usług
    ├── fail2ban/          # Banowanie po nieudanych próbach SSH
    ├── firewalld/         # Firewall (otwiera 2229, 51820)
    ├── rsyslog/           # Instalacja rsyslog
    └── wireguard/        # Serwer WireGuard
```

## Wymagania

```bash
ansible-galaxy collection install community.general ansible.posix
```

## Przygotowanie

1. Umieść plik konfiguracyjny WireGuard w katalogu VPS (np. `wg.conf`)
2. Zaktualizuj `group_vars/all.yml`:
   - `wg_server_config`: nazwa pliku konfiguracyjnego
   - `wg_interface_name`: nazwa interfejsu (np. wg0, vpn)
   - `wg_server_address`: adres IP serwera w sieci VPN

## Uruchomienie

### Krok 1: Bootstrap

```bash
ansible-playbook site-centos8.yml -l rocky9-bs
```

Pyta o nowe hasło root.

### Krok 2: Konfiguracja

```bash
ansible-playbook site-centos8.yml -l rocky9
```

Wykonuje: selinux → kernel_hardening → sshd → rsyslog → firewalld → fail2ban → wireguard

## Zmienne

### SSHd

| Zmienna | Domyślna | Opis |
|---------|----------|------|
| `sshd_port` | 2229 | Port nasłuchiwania SSH |
| `sshd_pubkey_auth` | yes | Autentykacja kluczem SSH |

### Bootstrap

| Zmienna | Domyślna | Opis |
|---------|----------|------|
| `ssh_public_key` | ~/.ssh/id_rsa.pub | Klucz publiczny SSH |

### WireGuard

| Zmienna | Domyślna | Opis |
|---------|----------|------|
| `wg_server_config` | wg.conf | Plik konfiguracyjny |
| `wg_interface_name` | wg0 | Nazwa interfejsu |
| `wg_listen_port` | 51820 | Port nasłuchiwania |
| `wg_server_address` | 10.11.12.1/24 | Adres serwera VPN |

### Fail2ban

| Zmienna | Domyślna | Opis |
|---------|----------|------|
| `fail2ban_bantime` | 3600 | Czas bana (sekundy) |
| `fail2ban_maxretry` | 3 | Max prób przed banem |
