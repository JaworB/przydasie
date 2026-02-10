# role_wireguard

Installs and configures WireGuard VPN.

## Variables

- `wireguard_addresses`: List of IP addresses for the host
- `wireguard_allowed_ips`: Allowed IP ranges
- `wireguard_endpoint`: VPN endpoint address and port
- `wireguard_private_key`: Host's private key (encrypted)
- `wireguard_public_key`: Peer's public key (encrypted)
- `wireguard_preshared_key`: Pre-shared key (encrypted)

## Tasks

- Installs WireGuard packages
- Generates wireguard configuration
- Enables and starts wireguard interface
