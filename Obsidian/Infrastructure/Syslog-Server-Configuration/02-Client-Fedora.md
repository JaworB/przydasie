# Syslog Client (Fedora/Ubuntu/Debian)

Configure rsyslog to send logs to a centralized syslog server.

## Installation

rsyslog is usually pre-installed. If not:

**Fedora:**
```bash
sudo dnf install -y rsyslog
```

**Ubuntu/Debian:**
```bash
sudo apt install -y rsyslog
```

## Configuration

Create `/etc/rsyslog.d/client.conf`:

```bash
# Remote logging to syslog server
# Send all logs to remote server via TCP
*.* @@<SERVER_IP>:514
```

Replace `<SERVER_IP>` with your syslog server's IP address (e.g., VPN IP).

### Configuration Explained

| Syntax | Description |
|--------|-------------|
| `*.*` | Match all messages |
| `@` | UDP (deprecated, use @@) |
| `@@` | TCP (reliable delivery) |
| `:514` | Default syslog port |

## Restart Service

```bash
sudo systemctl restart rsyslog
```

## Verify

Check that logs are being sent:

```bash
# Send test message
sudo logger "test syslog message"

# Check server logs (on syslog server)
sudo tail -f /var/log/remote/<hostname>.log
```

Replace `<hostname>` with this machine's hostname.

## Troubleshooting

### Connection issues

Check if rsyslog can connect to the server:

```bash
sudo ss -tn | grep 514
```

If you see `SYN-SENT`, the connection is being attempted.

### Check firewall

Make sure the syslog server has port 514/tcp open (see [[Syslog-Server-Configuration/04-Firewall]]).

### Check logs locally

Verify rsyslog is running:

```bash
sudo systemctl status rsyslog
```

Check for errors:

```bash
sudo journalctl -u rsyslog -n 20
```

## Complete Client Configuration Example

For more complex setups, here's a full configuration:

```bash
# Don't forward authpriv to remote (keep locally too)
authpriv.* /var/log/secure

# Forward everything else
*.* @@<SERVER_IP>:514

# Use TCP with custom template (optional)
$ActionQueueType LinkedList
$ActionQueueFileName remoteq
$ActionResumeRetryCount -1
$ActionQueueSaveOnShutdown on
```

This configuration:
- Keeps authpriv logs locally in /var/log/secure
- Forwards all other logs to the remote server
- Uses a persistent queue for reliable delivery during network outages
