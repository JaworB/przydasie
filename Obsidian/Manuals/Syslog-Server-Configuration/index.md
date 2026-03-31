# Syslog Server Configuration

Centralized logging infrastructure using rsyslog as the server and various clients.

## Overview

This guide covers setting up a centralized syslog server that collects logs from multiple hosts on a private VPN network. The server stores logs from each client in separate files organized by hostname.

## Architecture

```
                    +------------------+
                    |   Syslog Server  |
                    |   (lorien)       |
                    |   Port 514/tcp   |
                    +--------+---------+
                             |
         +-------------------+-------------------+
         |                   |                   |
+--------+--------+  +-------+--------+  +------+--------+
| Client 1        |  | Client 2        |  | Client 3      |
| (shire)         |  | (gondor)        |  | (other)       |
| rsyslog         |  | syslog-ng       |  | rsyslog       |
+-----------------+  +-----------------+  +---------------+
```

## Topics

### Server Setup
- [[Syslog-Server-Configuration/01-Server-Setup]] - Configure rsyslog server (Fedora)

### Client Configuration
- [[Syslog-Server-Configuration/02-Client-Fedora]] - Configure rsyslog client (Ubuntu/Debian/Fedora)
- [[Syslog-Server-Configuration/03-Client-Arch]] - Configure syslog-ng client (Arch Linux)

### Network
- [[Syslog-Server-Configuration/04-Firewall]] - Firewall configuration

## Supported Clients

| Distribution | Syslog Implementation | Config File |
|--------------|----------------------|-------------|
| Fedora/RHEL  | rsyslog | /etc/rsyslog.d/*.conf |
| Ubuntu/Debian | rsyslog | /etc/rsyslog.d/*.conf |
| Arch Linux | syslog-ng | /etc/syslog-ng/syslog-ng.conf |

## Log Storage Structure

On the server, logs are stored in `/var/log/remote/` with the following structure:

```
/var/log/remote/
├── hostname1.log              # All logs from hostname1
├── hostname1-messages.log    # Info-level logs
├── hostname1-secure.log      # Auth/authpriv logs
├── hostname1-cron.log        # Cron logs
├── hostname2.log
├── hostname2-messages.log
└── ...
```

## Requirements

- Server: rsyslog with TCP module
- Network: Private VPN network between all hosts
- Firewall: Port 514/tcp open on server
