# wg-manager

TUI for managing WireGuard interfaces (subnets) and peers on the VPS gateway.

Runs locally on the VPS as root, operates directly on `/etc/wireguard/*.conf`,
`wg`/`wg-quick`, `systemctl`, and `firewall-cmd`.

## Setup

```bash
cd scripts/python/wg-manager
python3 -m venv venv
./venv/bin/pip install -r requirements.txt
```

## Run

```bash
sudo ./venv/bin/python -m wgmgr
```

## Features

- List interfaces (subnets) with status, address range, port, peer count
- Create a new isolated subnet: generates server keypair, writes
  `/etc/wireguard/wgN.conf`, opens the port in firewalld, enables and starts
  `wg-quick@wgN`. Forwarding rules only allow `wgN <-> WAN`, so new subnets
  cannot reach each other or the existing `wg0` network by default.
- Delete a subnet: stops/disables the service, backs up and removes the
  config, closes the firewalld port.
- Manage peers per interface: add (generates keypair + PSK, allocates a free
  IP, live-syncs via `wg syncconf`), remove, view handshake/transfer stats.
- On peer creation, shows the client config as both text and an ASCII QR
  code. The client's private key is only ever shown at creation time — it is
  not persisted server-side.

## Keybindings

- Interface list: `n` new subnet, `x` delete subnet, `Enter` manage peers, `q` quit
- Peer list: `a` add peer, `x` remove peer, `Esc` back
- Any form: `Esc` to cancel

## Backups

Every config change is backed up to `/etc/wireguard/backups/` with a
timestamp before being overwritten.
