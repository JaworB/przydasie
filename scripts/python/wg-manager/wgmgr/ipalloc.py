from __future__ import annotations

import ipaddress

from .conf import Interface


def find_free_ip(iface: Interface) -> str:
    network = ipaddress.ip_network(iface.address, strict=False)
    used = {ipaddress.ip_interface(iface.address).ip}
    for peer in iface.peers:
        for entry in peer.allowed_ips.split(","):
            entry = entry.strip()
            if not entry:
                continue
            addr = ipaddress.ip_interface(entry).ip
            used.add(addr)

    for host in network.hosts():
        if host not in used:
            return str(host)
    raise ValueError(f"No free IP addresses left in {network}")
