# Syslog Client (Arch Linux)

Configure syslog-ng to send logs to a centralized syslog server.

## Installation

syslog-ng is available in the official repositories:

```bash
sudo pacman -S syslog-ng
```

## Configuration

Edit `/etc/syslog-ng/syslog-ng.conf` and modify the remote destination.

Find the existing `destination d_remote` section and update it:

```bash
# Remote logging to syslog server
destination d_remote {
    network("<SERVER_IP>"
        port(514)
        transport(tcp)
        spoof-source(yes)
    );
};

log {
    source(s_local);
    destination(d_remote);
};
```

Replace `<SERVER_IP>` with your syslog server's IP address.

### Configuration Explained

| Directive | Description |
|-----------|-------------|
| `destination d_remote` | Define remote destination |
| `network("...")` | Server IP address |
| `port(514)` | Syslog port |
| `transport(tcp)` | Use TCP (more reliable than UDP) |
| `spoof-source(yes)` | Preserve original source IP |

## Enable and Start Service

```bash
sudo systemctl enable --now syslog-ng@default
```

Note: Arch uses a template service, so use `@default` suffix.

## Verify

Check if syslog-ng is running:

```bash
sudo systemctl status syslog-ng@default
```

Check active connections:

```bash
sudo ss -tn | grep 514
```

## Troubleshooting

### Service won't start

Check for configuration errors:

```bash
sudo syslog-ng -s -f /etc/syslog-ng/syslog-ng.conf
```

### Connection issues

Check the logs:

```bash
sudo journalctl -u syslog-ng@default -n 20
```

### Check firewall

Make sure the syslog server has port 514/tcp open (see [[Syslog-Server-Configuration/04-Firewall]]).

## Complete Configuration Example

For a more complete setup with local logging:

```bash
# Remote logging to syslog server
destination d_remote {
    network("10.66.66.10"
        port(514)
        transport(tcp)
        spoof-source(yes)
    );
};

# Local logging destinations
destination d_secure {
    file("/var/log/secure");
};

destination d_messages_local {
    file("/var/log/messages");
};

destination d_all_local {
    file("/var/log/all");
};

# Remote log
log {
    source(s_local);
    destination(d_remote);
};

# Local logs - authpriv -> secure, info -> messages, all -> all
log {
    source(s_local);
    filter(f_authpriv);
    destination(d_secure);
};

log {
    source(s_local);
    filter(f_messages);
    destination(d_messages_local);
};

log {
    source(s_local);
    destination(d_all_local);
};
```

This configuration:
- Sends all logs to the remote server
- Keeps authpriv logs locally in /var/log/secure
- Keeps info-level logs locally in /var/log/messages
- Keeps all logs locally in /var/log/all
