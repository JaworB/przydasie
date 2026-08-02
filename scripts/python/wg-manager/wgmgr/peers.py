from __future__ import annotations

import ipaddress
from dataclasses import dataclass

from . import wgcli
from .conf import Interface, Peer, load, save
from .ipalloc import find_free_ip
from .interfaces import backup


@dataclass
class LivePeer:
    peer: Peer
    latest_handshake: int
    rx_bytes: int
    tx_bytes: int


def list_peers(interface_name: str) -> list[LivePeer]:
    iface = load(interface_name)
    live_by_key: dict[str, tuple[int, int, int]] = {}
    for line in wgcli.wg_show_dump(interface_name).splitlines()[1:]:
        cols = line.split("\t")
        if len(cols) < 8:
            continue
        pubkey, _, _, _, handshake, rx, tx, _ = cols[:8]
        live_by_key[pubkey] = (int(handshake), int(rx), int(tx))

    result = []
    for peer in iface.peers:
        handshake, rx, tx = live_by_key.get(peer.public_key, (0, 0, 0))
        result.append(LivePeer(peer=peer, latest_handshake=handshake, rx_bytes=rx, tx_bytes=tx))
    return result


def add_peer(interface_name: str, name: str) -> tuple[Peer, str]:
    iface = load(interface_name)
    if any(p.name == name for p in iface.peers):
        raise ValueError(f"Peer '{name}' already exists on {interface_name}")

    client_private_key = wgcli.genkey()
    client_public_key = wgcli.pubkey(client_private_key)
    psk = wgcli.genpsk()
    ip = find_free_ip(iface)

    peer = Peer(
        name=name,
        public_key=client_public_key,
        preshared_key=psk,
        allowed_ips=f"{ip}/32",
    )

    backup(interface_name)
    iface.peers.append(peer)
    save(iface)
    wgcli.wg_syncconf(interface_name, str(iface.path()))

    return peer, client_private_key


def remove_peer(interface_name: str, name: str):
    iface = load(interface_name)
    remaining = [p for p in iface.peers if p.name != name]
    if len(remaining) == len(iface.peers):
        raise ValueError(f"Peer '{name}' not found on {interface_name}")

    backup(interface_name)
    iface.peers = remaining
    save(iface)
    wgcli.wg_syncconf(interface_name, str(iface.path()))


def build_client_config(
    iface: Interface,
    peer: Peer,
    client_private_key: str,
    endpoint_host: str,
    allowed_ips: str | None = None,
    dns: str | None = None,
) -> str:
    server_public_key = wgcli.pubkey(iface.private_key)
    client_address = peer.allowed_ips.split(",")[0].strip()
    network = ipaddress.ip_network(iface.address, strict=False)
    routed = allowed_ips or str(network)

    lines = [
        "[Interface]",
        f"PrivateKey = {client_private_key}",
        f"Address = {client_address}",
    ]
    if dns:
        lines.append(f"DNS = {dns}")
    lines += [
        "",
        "[Peer]",
        f"PublicKey = {server_public_key}",
        f"PresharedKey = {peer.preshared_key}",
        f"Endpoint = {endpoint_host}:{iface.listen_port}",
        f"AllowedIPs = {routed}",
        "PersistentKeepalive = 25",
    ]
    return "\n".join(lines) + "\n"
