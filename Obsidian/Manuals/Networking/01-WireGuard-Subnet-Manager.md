# WireGuard subnet manager (vps)

TUI for managing WireGuard on the VPS gateway (`10.66.66.1`) — creating new isolated subnets (interfaces) and their peers, without hand-editing `/etc/wireguard/*.conf` or firewalld rules.

Source: `scripts/python/wg-manager/` in this repo (Python, Textual). Runs locally on the VPS as root — the repo itself is not cloned there, only the `wgmgr/` package and `requirements.txt` are deployed to `/opt/wg-manager/`.

## Why subnets, not just peers

The existing `wg0` (`10.66.66.0/24`) is the main VPN — gondor, rivendell, shire, lorien, phones, etc. This tool lets a *new*, separate subnet be spun up on the same VPS (its own interface, port, address range), isolated from `wg0` and from any other subnet, for cases where a peer group shouldn't be able to reach the main network.

## Isolation model — read this before creating a subnet

Each new interface gets its own `iptables` rules in its `PostUp`/`PostDown`:

```
iptables -I FORWARD -i <name> -j DROP            # catch-all, inserted first
iptables -I FORWARD -i <wan> -o <name> -j ACCEPT  # then this
iptables -I FORWARD -i <name> -o <wan> -j ACCEPT  # then this (ends up on top)
```

Insertion order matters: because `-I` always inserts at position 1, doing the DROP first and the two ACCEPTs after means the final chain reads, top to bottom, `<name>→wan ACCEPT`, `wan→<name> ACCEPT`, `<name>→* DROP`. Get this backwards and the interface is **not** isolated — the DROP would sit below existing permissive rules from other interfaces and never even apply correctly relative to new ones added later.

**Discovered while testing (2026-08-02):** the VPS's `FORWARD` chain default policy is `ACCEPT` (Docker sets this), not `DROP`. This means "just don't add an ACCEPT rule between two interfaces" does **not** isolate them — traffic falls through to the ACCEPT policy at the end of the chain. Every new interface *must* carry its own explicit DROP catch-all, which is what `wgmgr.interfaces.create_interface` does. Verify with `iptables -L FORWARD -n -v --line-numbers` after creating a subnet — the new interface's DROP rule should appear before `wg0`'s rules.

**Known asymmetry:** `wg0`'s own `PostUp` (hand-written, pre-dates this tool) has `iptables -I FORWARD -i wg0 -j ACCEPT` with no `-o` restriction — a blanket accept for anything sourced from `wg0`, including toward new subnets. Combined with a new subnet's own DROP-catch-all, this means a `wg0` peer's packets *into* a new subnet get forwarded but the *replies* get dropped (asymmetric, effectively non-functional but not a clean block). Tightening `wg0`'s rule to `-i wg0 -o eth0 -j ACCEPT` would close this properly but hasn't been done — it touches the live production tunnel and needs a deliberate, separate change.

## Setup

```bash
ssh vps
mkdir -p /opt/wg-manager
# from gondor:
scp -P 2229 -r scripts/python/wg-manager/wgmgr scripts/python/wg-manager/requirements.txt root@10.66.66.1:/opt/wg-manager/
ssh vps 'cd /opt/wg-manager && python3 -m venv venv && ./venv/bin/pip install -r requirements.txt'
```

## Run

```bash
ssh vps
cd /opt/wg-manager && sudo ./venv/bin/python -m wgmgr
```

Keybindings: interface list — `n` new subnet, `x` delete subnet, `Enter` manage peers, `q` quit. Peer list — `a` add peer, `x` remove peer, `Esc` back. The client config (text + ASCII QR) is only shown once, right after adding a peer — the private key is never stored server-side, so a peer can't be re-exported later; remove and re-add it instead.

## Backups

Every config write is copied to `/etc/wireguard/backups/<name>.conf.<timestamp>.bak` first.

## Testing done

Created a real test subnet (`wg2`, `10.66.67.0/24`, port `51821`) on vps and added shire as a peer on it (second interface `wg1` on shire, separate from its normal `wg0`). Confirmed: handshake, ping to the gateway, and — via `iptables -L FORWARD -n -v` plus a forced-route/widened-AllowedIPs pivot attempt from shire — that the new subnet cannot reach `10.66.66.0/24`. Torn down afterwards; no permanent second subnet exists yet.
