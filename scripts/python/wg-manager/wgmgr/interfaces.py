from __future__ import annotations

import ipaddress
import shutil
from dataclasses import dataclass
from datetime import datetime

from . import wgcli
from .conf import WG_DIR, Interface, list_interface_names, load, save

BACKUP_DIR = WG_DIR / "backups"


@dataclass
class InterfaceStatus:
    name: str
    address: str
    listen_port: int
    peer_count: int
    active: bool


def backup(name: str):
    src = WG_DIR / f"{name}.conf"
    if not src.exists():
        return
    BACKUP_DIR.mkdir(mode=0o700, exist_ok=True)
    stamp = datetime.now().strftime("%Y%m%d%H%M%S")
    shutil.copy2(src, BACKUP_DIR / f"{name}.conf.{stamp}.bak")


def list_status() -> list[InterfaceStatus]:
    statuses = []
    for name in list_interface_names():
        iface = load(name)
        statuses.append(
            InterfaceStatus(
                name=name,
                address=iface.address,
                listen_port=iface.listen_port,
                peer_count=len(iface.peers),
                active=wgcli.service_is_active(name),
            )
        )
    return statuses


def create_interface(
    name: str, cidr: str, port: int, wan_iface: str = "eth0"
) -> Interface:
    if name in list_interface_names():
        raise ValueError(f"Interface {name} already exists")

    network = ipaddress.ip_network(cidr, strict=False)
    gateway_address = f"{next(network.hosts())}/{network.prefixlen}"

    private_key = wgcli.genkey()
    iface = Interface(
        name=name,
        address=gateway_address,
        listen_port=port,
        private_key=private_key,
        post_up=[
            f"iptables -I INPUT -p udp --dport {port} -j ACCEPT",
            # inserted in this order so the final chain reads (top to bottom):
            # {name}->{wan} ACCEPT, {wan}->{name} ACCEPT, {name}->* DROP (catch-all)
            f"iptables -I FORWARD -i {name} -j DROP",
            f"iptables -I FORWARD -i {wan_iface} -o {name} -j ACCEPT",
            f"iptables -I FORWARD -i {name} -o {wan_iface} -j ACCEPT",
            f"iptables -t nat -A POSTROUTING -s {cidr} -o {wan_iface} -j MASQUERADE",
        ],
        post_down=[
            f"iptables -D INPUT -p udp --dport {port} -j ACCEPT",
            f"iptables -D FORWARD -i {wan_iface} -o {name} -j ACCEPT",
            f"iptables -D FORWARD -i {name} -o {wan_iface} -j ACCEPT",
            f"iptables -D FORWARD -i {name} -j DROP",
            f"iptables -t nat -D POSTROUTING -s {cidr} -o {wan_iface} -j MASQUERADE",
        ],
        peers=[],
    )
    save(iface)
    wgcli.firewalld_add_port(port)
    wgcli.service_enable(name)
    wgcli.service_start(name)
    return iface


def delete_interface(name: str):
    if name not in list_interface_names():
        raise ValueError(f"Interface {name} does not exist")
    iface = load(name)
    wgcli.service_stop(name)
    wgcli.service_disable(name)
    backup(name)
    (WG_DIR / f"{name}.conf").unlink()
    wgcli.firewalld_remove_port(iface.listen_port)
