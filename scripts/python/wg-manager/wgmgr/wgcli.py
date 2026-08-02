from __future__ import annotations

import subprocess


class CommandError(RuntimeError):
    pass


def run(args: list[str], input: str | None = None) -> str:
    result = subprocess.run(
        args, input=input, capture_output=True, text=True
    )
    if result.returncode != 0:
        raise CommandError(f"{' '.join(args)} failed: {result.stderr.strip()}")
    return result.stdout.strip()


def genkey() -> str:
    return run(["wg", "genkey"])


def pubkey(private_key: str) -> str:
    return run(["wg", "pubkey"], input=private_key + "\n")


def genpsk() -> str:
    return run(["wg", "genpsk"])


def wg_show_dump(interface: str) -> str:
    return run(["wg", "show", interface, "dump"])


def wg_show_all() -> str:
    return run(["wg", "show", "all", "dump"])


def wg_syncconf(interface: str, conf_path: str):
    stripped = run(["wg-quick", "strip", conf_path])
    run(["wg", "syncconf", interface, "/dev/stdin"], input=stripped + "\n")


def service_start(interface: str):
    run(["systemctl", "start", f"wg-quick@{interface}"])


def service_stop(interface: str):
    run(["systemctl", "stop", f"wg-quick@{interface}"])


def service_enable(interface: str):
    run(["systemctl", "enable", f"wg-quick@{interface}"])


def service_disable(interface: str):
    run(["systemctl", "disable", f"wg-quick@{interface}"])


def service_is_active(interface: str) -> bool:
    result = subprocess.run(
        ["systemctl", "is-active", f"wg-quick@{interface}"],
        capture_output=True,
        text=True,
    )
    return result.stdout.strip() == "active"


def firewalld_add_port(port: int, proto: str = "udp"):
    run(["firewall-cmd", "--permanent", f"--add-port={port}/{proto}"])
    run(["firewall-cmd", "--reload"])


def firewalld_remove_port(port: int, proto: str = "udp"):
    run(["firewall-cmd", "--permanent", f"--remove-port={port}/{proto}"])
    run(["firewall-cmd", "--reload"])


def firewalld_list_ports() -> str:
    return run(["firewall-cmd", "--list-ports"])
