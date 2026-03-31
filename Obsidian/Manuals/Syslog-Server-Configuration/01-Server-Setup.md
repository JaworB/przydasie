# Syslog Server Setup (Fedora)

Configure rsyslog as a centralized server that receives logs from remote clients over TCP.

## Installation

rsyslog is usually pre-installed on Fedora. If not:

```bash
sudo dnf install -y rsyslog
sudo systemctl enable --now rsyslog
```

## Create Log Directory

```bash
sudo mkdir -p /var/log/remote
```

## Server Configuration

Create `/etc/rsyslog.d/server.conf`:

```bash
module(load="imtcp")

input(type="imtcp" port="514")

template(name="RemoteHostFile" type="string" string="/var/log/remote/%HOSTNAME%.log")
template(name="RemoteHostMessages" type="string" string="/var/log/remote/%HOSTNAME%-messages.log")
template(name="RemoteHostSecure" type="string" string="/var/log/remote/%HOSTNAME%-secure.log")
template(name="RemoteHostCron" type="string" string="/var/log/remote/%HOSTNAME%-cron.log")

if $fromhost != "localhost" and $fromhost-ip != "127.0.0.1" then {
    authpriv.* action(type="omfile" dynaFile="RemoteHostSecure")
    cron.* action(type="omfile" dynaFile="RemoteHostCron")
    mail.* action(type="omfile" dynaFile="RemoteHostFile")
    *.info;mail.none;authpriv.none;cron.none action(type="omfile" dynaFile="RemoteHostMessages")

    *.* action(type="omfile" dynaFile="RemoteHostFile")
}
```

### Configuration Explained

| Directive | Description |
|-----------|-------------|
| `module(load="imtcp")` | Load TCP input module |
| `input(type="imtcp" port="514")` | Listen on TCP port 514 |
| `template(...)` | Define log file paths using hostname |
| `if $fromhost != ...` | Skip logs from localhost |

### Template Variables

| Variable | Description |
|----------|-------------|
| `%HOSTNAME%` | Hostname of the sending client |
| `%PROGRAMNAME%` | Program that generated the log |

## Restart Service

```bash
sudo systemctl restart rsyslog
```

## Verify

Check if rsyslog is listening on port 514:

```bash
sudo ss -tuln | grep 514
```

Expected output:
```
tcp   LISTEN 0      25           0.0.0.0:514        0.0.0.0:*
tcp   LISTEN 0      25              [::]:514           [::]:*
```

## Check Received Logs

```bash
sudo ls -la /var/log/remote/
sudo tail -f /var/log/remote/*.log
```

## Troubleshooting

### Port not listening

- Check firewall: `sudo firewall-cmd --list-all`
- Make sure port 514/tcp is open (see [[Syslog-Server-Configuration/04-Firewall]])

### Logs not arriving

- Check rsyslog status: `sudo systemctl status rsyslog`
- Check logs: `sudo journalctl -u rsyslog -f`
- Verify client connectivity: `nc -zv <server-ip> 514`

### Permission issues

Ensure the log directory has correct permissions:

```bash
sudo chown root:adm /var/log/remote
sudo chmod 755 /var/log/remote
```

### SELinux Issues

If SELinux is enabled and blocking rsyslog:

1. Check SELinux status:
```bash
sudo getenforce
```

2. Check for denied operations:
```bash
sudo ausearch -c rsyslogd
sudo journalctl -u rsyslog -p err -b
```

3. If there are denials, generate a custom policy:
```bash
sudo ausearch -c 'rsyslogd' --raw | audit2allow -M rsyslog-custom
sudo semodule -i rsyslog-custom.pp
```

4. To temporarily disable SELinux enforcement (for testing):
```bash
sudo setenforce 0
```

5. To permanently set SELinux mode, edit `/etc/selinux/config`:
```bash
sudo sed -i 's/^SELINUX=.*/SELINUX=enforcing/' /etc/selinux/config
```

**Note:** On Fedora, rsyslog typically works with SELinux in enforcing mode without additional policies. The default "targeted" policy includes necessary permissions for rsyslog.
