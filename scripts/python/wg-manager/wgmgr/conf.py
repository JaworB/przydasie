from __future__ import annotations

import re
from dataclasses import dataclass, field
from pathlib import Path

WG_DIR = Path("/etc/wireguard")


@dataclass
class Peer:
    name: str
    public_key: str
    preshared_key: str
    allowed_ips: str
    endpoint: str | None = None
    persistent_keepalive: int | None = None


@dataclass
class Interface:
    name: str
    address: str
    listen_port: int
    private_key: str
    post_up: list[str] = field(default_factory=list)
    post_down: list[str] = field(default_factory=list)
    peers: list[Peer] = field(default_factory=list)

    @property
    def cidr(self) -> str:
        return self.address

    def path(self) -> Path:
        return WG_DIR / f"{self.name}.conf"


def _parse_value(line: str) -> tuple[str, str]:
    key, _, value = line.partition("=")
    return key.strip(), value.strip()


def parse(name: str, text: str) -> Interface:
    lines = text.splitlines()
    iface_kv: dict[str, str] = {}
    post_up: list[str] = []
    post_down: list[str] = []
    peers: list[Peer] = []

    section = None
    current_name = None
    next_name = None
    peer_kv: dict[str, str] = {}

    def flush_peer():
        nonlocal peer_kv
        if peer_kv:
            peers.append(
                Peer(
                    name=current_name or peer_kv.get("PublicKey", "")[:8],
                    public_key=peer_kv.get("PublicKey", ""),
                    preshared_key=peer_kv.get("PresharedKey", ""),
                    allowed_ips=peer_kv.get("AllowedIPs", ""),
                    endpoint=peer_kv.get("Endpoint"),
                    persistent_keepalive=int(peer_kv["PersistentKeepalive"])
                    if "PersistentKeepalive" in peer_kv
                    else None,
                )
            )
        peer_kv = {}

    for raw in lines:
        line = raw.strip()
        if not line:
            continue
        comment_match = re.match(r"^###\s*Client\s+(.+)$", line)
        if comment_match:
            next_name = comment_match.group(1).strip()
            continue
        if line.startswith("#") or line.startswith(";"):
            continue
        if line == "[Interface]":
            section = "interface"
            continue
        if line == "[Peer]":
            flush_peer()
            current_name = next_name
            next_name = None
            section = "peer"
            continue
        if "=" not in line:
            continue
        key, value = _parse_value(line)
        if section == "interface":
            if key == "PostUp":
                post_up.append(value)
            elif key == "PostDown":
                post_down.append(value)
            else:
                iface_kv[key] = value
        elif section == "peer":
            peer_kv[key] = value
    flush_peer()

    return Interface(
        name=name,
        address=iface_kv.get("Address", ""),
        listen_port=int(iface_kv.get("ListenPort", "0")),
        private_key=iface_kv.get("PrivateKey", ""),
        post_up=post_up,
        post_down=post_down,
        peers=peers,
    )


def load(name: str) -> Interface:
    path = WG_DIR / f"{name}.conf"
    return parse(name, path.read_text())


def render(iface: Interface) -> str:
    out = ["[Interface]"]
    out.append(f"Address = {iface.address}")
    out.append(f"ListenPort = {iface.listen_port}")
    out.append(f"PrivateKey = {iface.private_key}")
    for rule in iface.post_up:
        out.append(f"PostUp = {rule}")
    for rule in iface.post_down:
        out.append(f"PostDown = {rule}")
    out.append("")
    for peer in iface.peers:
        out.append(f"### Client {peer.name}")
        out.append("[Peer]")
        out.append(f"PublicKey = {peer.public_key}")
        out.append(f"PresharedKey = {peer.preshared_key}")
        out.append(f"AllowedIPs = {peer.allowed_ips}")
        if peer.endpoint:
            out.append(f"Endpoint = {peer.endpoint}")
        if peer.persistent_keepalive:
            out.append(f"PersistentKeepalive = {peer.persistent_keepalive}")
        out.append("")
    return "\n".join(out).rstrip() + "\n"


def save(iface: Interface):
    path = iface.path()
    path.write_text(render(iface))
    path.chmod(0o600)


def list_interface_names() -> list[str]:
    if not WG_DIR.is_dir():
        return []
    return sorted(p.stem for p in WG_DIR.glob("*.conf"))
