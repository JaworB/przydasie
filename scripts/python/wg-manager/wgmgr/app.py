from __future__ import annotations

import socket
from pathlib import Path

from textual.app import App, ComposeResult
from textual.binding import Binding
from textual.containers import Vertical
from textual.screen import ModalScreen, Screen
from textual.widgets import Button, DataTable, Footer, Header, Input, Label, Static

from . import interfaces, peers, qr
from .conf import load


class ConfirmScreen(ModalScreen[bool]):
    def __init__(self, question: str):
        super().__init__()
        self.question = question

    def compose(self) -> ComposeResult:
        with Vertical(id="confirm-box"):
            yield Label(self.question)
            yield Button("Yes", id="yes", variant="error")
            yield Button("No", id="no", variant="primary")

    def on_button_pressed(self, event: Button.Pressed) -> None:
        self.dismiss(event.button.id == "yes")


class NewInterfaceScreen(Screen):
    BINDINGS = [Binding("escape", "app.pop_screen", "Back")]

    def compose(self) -> ComposeResult:
        yield Header()
        with Vertical(id="form"):
            yield Label("New subnet / interface")
            yield Input(placeholder="interface name, e.g. wg2", id="name")
            yield Input(placeholder="CIDR, e.g. 10.66.67.0/24", id="cidr")
            yield Input(placeholder="listen port, e.g. 51821", id="port")
            yield Input(placeholder="WAN interface (default eth0)", id="wan")
            yield Button("Create", id="create", variant="success")
        yield Footer()

    def on_button_pressed(self, event: Button.Pressed) -> None:
        name = self.query_one("#name", Input).value.strip()
        cidr = self.query_one("#cidr", Input).value.strip()
        port_raw = self.query_one("#port", Input).value.strip()
        wan = self.query_one("#wan", Input).value.strip() or "eth0"

        if not name or not cidr or not port_raw:
            self.app.notify("Name, CIDR and port are required", severity="error")
            return
        try:
            port = int(port_raw)
            interfaces.create_interface(name, cidr, port, wan)
        except Exception as exc:
            self.app.notify(str(exc), severity="error")
            return
        self.app.notify(f"Interface {name} created and started")
        self.app.pop_screen()
        self.app.refresh_interfaces()


class ClientConfigScreen(Screen):
    BINDINGS = [Binding("escape", "app.pop_screen", "Back")]

    def __init__(self, config_text: str, peer_name: str):
        super().__init__()
        self.config_text = config_text
        self.peer_name = peer_name

    def compose(self) -> ComposeResult:
        yield Header()
        with Vertical(id="qr-box"):
            yield Static(qr.ascii_qr(self.config_text), id="qr", markup=False)
            yield Static(self.config_text, id="conf-text", markup=False)
            yield Button("Save PNG + .conf to /root/wg-manager-exports/", id="save")
        yield Footer()

    def on_button_pressed(self, event: Button.Pressed) -> None:
        export_dir = Path("/root/wg-manager-exports")
        export_dir.mkdir(exist_ok=True)
        png_path = export_dir / f"{self.peer_name}.png"
        conf_path = export_dir / f"{self.peer_name}.conf"
        qr.save_png(self.config_text, str(png_path))
        conf_path.write_text(self.config_text)
        conf_path.chmod(0o600)
        self.app.notify(f"Saved {png_path} and {conf_path}")


class NewPeerScreen(Screen):
    BINDINGS = [Binding("escape", "app.pop_screen", "Back")]

    def __init__(self, interface_name: str):
        super().__init__()
        self.interface_name = interface_name

    def compose(self) -> ComposeResult:
        yield Header()
        with Vertical(id="form"):
            yield Label(f"New peer on {self.interface_name}")
            yield Input(placeholder="peer name, e.g. laptop", id="name")
            yield Input(
                placeholder=f"endpoint host (default: {self._default_endpoint()})",
                id="endpoint",
            )
            yield Button("Add peer", id="add", variant="success")
        yield Footer()

    def _default_endpoint(self) -> str:
        return socket.getfqdn()

    def on_button_pressed(self, event: Button.Pressed) -> None:
        name = self.query_one("#name", Input).value.strip()
        endpoint = self.query_one("#endpoint", Input).value.strip() or self._default_endpoint()

        if not name:
            self.app.notify("Peer name is required", severity="error")
            return
        try:
            peer, private_key = peers.add_peer(self.interface_name, name)
            iface = load(self.interface_name)
            config_text = peers.build_client_config(iface, peer, private_key, endpoint)
        except Exception as exc:
            self.app.notify(str(exc), severity="error")
            return

        self.app.notify(f"Peer {name} added")
        self.app.pop_screen()
        self.app.refresh_peers()
        self.app.push_screen(ClientConfigScreen(config_text, name))


class PeerListScreen(Screen):
    BINDINGS = [
        Binding("escape", "app.pop_screen", "Back"),
        Binding("a", "add_peer", "Add peer"),
        Binding("x", "remove_peer", "Remove peer"),
    ]

    def __init__(self, interface_name: str):
        super().__init__()
        self.interface_name = interface_name

    def compose(self) -> ComposeResult:
        yield Header()
        yield DataTable(id="peers", cursor_type="row")
        yield Footer()

    def on_mount(self) -> None:
        table = self.query_one("#peers", DataTable)
        table.add_columns("Name", "Allowed IPs", "Last handshake (s ago)", "RX", "TX")
        self.reload()

    def reload(self) -> None:
        table = self.query_one("#peers", DataTable)
        table.clear()
        for lp in peers.list_peers(self.interface_name):
            table.add_row(
                lp.peer.name,
                lp.peer.allowed_ips,
                str(lp.latest_handshake) if lp.latest_handshake else "-",
                str(lp.rx_bytes),
                str(lp.tx_bytes),
                key=lp.peer.name,
            )

    def action_add_peer(self) -> None:
        self.app.push_screen(NewPeerScreen(self.interface_name))

    def action_remove_peer(self) -> None:
        table = self.query_one("#peers", DataTable)
        if table.cursor_row is None:
            return
        row_key = table.coordinate_to_cell_key(table.cursor_coordinate).row_key
        name = row_key.value

        def handle(confirmed: bool | None) -> None:
            if confirmed:
                try:
                    peers.remove_peer(self.interface_name, name)
                except Exception as exc:
                    self.app.notify(str(exc), severity="error")
                    return
                self.app.notify(f"Peer {name} removed")
                self.reload()

        self.app.push_screen(ConfirmScreen(f"Remove peer '{name}'?"), handle)


class InterfaceListScreen(Screen):
    BINDINGS = [
        Binding("n", "new_interface", "New subnet"),
        Binding("x", "delete_interface", "Delete subnet"),
        Binding("enter", "open_peers", "Manage peers", show=True),
        Binding("q", "app.quit", "Quit"),
    ]

    def compose(self) -> ComposeResult:
        yield Header()
        yield DataTable(id="interfaces", cursor_type="row")
        yield Footer()

    def on_data_table_row_selected(self, event: DataTable.RowSelected) -> None:
        self.action_open_peers()

    def on_mount(self) -> None:
        table = self.query_one("#interfaces", DataTable)
        table.add_columns("Name", "Address", "Port", "Peers", "Active")
        self.reload()

    def reload(self) -> None:
        table = self.query_one("#interfaces", DataTable)
        table.clear()
        for status in interfaces.list_status():
            table.add_row(
                status.name,
                status.address,
                str(status.listen_port),
                str(status.peer_count),
                "up" if status.active else "down",
                key=status.name,
            )

    def _selected_name(self) -> str | None:
        table = self.query_one("#interfaces", DataTable)
        if table.cursor_row is None or table.row_count == 0:
            return None
        row_key = table.coordinate_to_cell_key(table.cursor_coordinate).row_key
        return row_key.value

    def action_new_interface(self) -> None:
        self.app.push_screen(NewInterfaceScreen())

    def action_open_peers(self) -> None:
        name = self._selected_name()
        if name:
            self.app.push_screen(PeerListScreen(name))

    def action_delete_interface(self) -> None:
        name = self._selected_name()
        if not name:
            return

        def handle(confirmed: bool | None) -> None:
            if confirmed:
                try:
                    interfaces.delete_interface(name)
                except Exception as exc:
                    self.app.notify(str(exc), severity="error")
                    return
                self.app.notify(f"Interface {name} deleted")
                self.reload()

        self.app.push_screen(ConfirmScreen(f"Delete subnet '{name}'? This removes all its peers."), handle)


class WgManagerApp(App):
    CSS = """
    #form, #confirm-box, #qr-box {
        padding: 1 2;
        width: 60;
        height: auto;
        border: round $primary;
        margin: 1;
    }
    #qr {
        width: auto;
    }
    """

    def on_mount(self) -> None:
        self.push_screen(InterfaceListScreen())

    def refresh_interfaces(self) -> None:
        for screen in self.screen_stack:
            if isinstance(screen, InterfaceListScreen):
                screen.reload()

    def refresh_peers(self) -> None:
        for screen in self.screen_stack:
            if isinstance(screen, PeerListScreen):
                screen.reload()


def main():
    WgManagerApp().run()


if __name__ == "__main__":
    main()
