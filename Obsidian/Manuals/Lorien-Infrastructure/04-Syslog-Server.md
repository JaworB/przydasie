# Syslog Server

Lorien runs rsyslog as a centralized syslog server for the VPN network.

## Configuration

**File**: `/etc/rsyslog.d/server.conf`

```bash
module(load="imtcp")

input(type="imtcp" port="514")

template(name="RemoteHostFile" type="string" string="/var/log/remote/%HOSTNAME%.log")
template(name="RemoteHostMessages" type="string" string="/var/log/remote/%HOSTNAME%-messages.log")
template(name="RemoteHostSecure" type="string" string="/var/log/remote/%HOSTNAME%-secure.log")
template(name="RemoteHostCron" type="string" string="/var/log/remote/%HOSTNAME%-cron.log")

if $fromhost != "lorien" and $fromhost-ip != "127.0.0.1" and $fromhost-ip != "10.66.66.10" then {
    authpriv.* action(type="omfile" dynaFile="RemoteHostSecure")
    cron.* action(type="omfile" dynaFile="RemoteHostCron")
    mail.* action(type="omfile" dynaFile="RemoteHostFile")
    *.info;mail.none;authpriv.none;cron.none action(type="omfile" dynaFile="RemoteHostMessages")

    *.* action(type="omfile" dynaFile="RemoteHostFile")
}
```

## How It Works

1. Listens on TCP port 514
2. Receives logs from remote hosts
3. Filters out local traffic (lorien itself, localhost)
4. Routes logs by facility:
   - `authpriv.*` → `*-secure.log`
   - `cron.*` → `*-cron.log`
   - `mail.*` → `*.log` (via RemoteHostFile)
   - `*.info` (excluding mail, authpriv, cron) → `*-messages.log`
   - `*.*` → `*.log` (everything)

## Log Storage

**Directory**: `/var/log/remote/`

```
/var/log/remote/
├── hassio.log              # Full logs from hassio
├── hassio-messages.log     # Info-level logs
├── hassio-secure.log       # Auth/authpriv logs
├── hassio-cron.log         # Cron logs
├── shire.log
├── shire-messages.log
├── shire-secure.log
├── shire-cron.log
├── gondor.log
├── gondor-messages.log
├── nginx.jawor.org.log
└── ...
```

## Template Variables

| Variable | Description |
|----------|-------------|
| `%HOSTNAME%` | Hostname of the sending client |
| `%PROGRAMNAME%` | Program that generated the log |

## Connected Clients

| Hostname | OS | Client | Status |
|----------|-----|--------|--------|
| shire | Debian (RPi) | rsyslog | Active |
| gondor | Arch Linux | syslog-ng | Active |
| jawor | Rocky Linux (VPS) | rsyslog | Active |
| nginx.jawor.org | Rocky Linux (VPS) | rsyslog | Active (same host as jawor) |

## Local Lorien Services

Hostnamy BIOS, Board, ELF, Stack widoczne w `/var/log/remote/` to lokalne procesy lub kontenery
działające na samym Lorient — nie są to zdalne hosty wysyłające logi przez sieć.

## Service Management

```bash
# Check status
sudo systemctl status rsyslog

# Restart
sudo systemctl restart rsyslog

# Check listening
sudo ss -tuln | grep 514

# Check received logs
sudo ls -la /var/log/remote/
sudo tail -f /var/log/remote/*.log
```

## Firewall

Port 514/tcp must be open:

```bash
sudo firewall-cmd --permanent --add-port=514/tcp
sudo firewall-cmd --reload
```

## Log Rotation

Logs are rotated by logrotate (default Fedora config). Old logs are compressed with dates:

```
ELF.log
ELF.log-20260504.gz
ELF.log-20260525.gz
ELF.log-20260606.gz
```

## See Also

- [[Syslog-Server-Configuration/]] - Detailed client setup guides
- [[01-Overview]] - System overview
