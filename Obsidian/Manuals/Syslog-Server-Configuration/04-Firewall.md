# Firewall Configuration

Configure firewall to allow syslog traffic and VPN connectivity.

## Fedora (firewalld)

### Syslog Server (Port 514/tcp)

```bash
# Add syslog port
sudo firewall-cmd --permanent --add-port=514/tcp
sudo firewall-cmd --reload

# Verify
sudo firewall-cmd --list-all
```

Expected output:
```
services: cockpit dhcpv6-client ssh
ports: 514/tcp
```

### Optional: WireGuard (Port 56510/udp)

If your VPN server uses WireGuard:

```bash
# Add WireGuard port
sudo firewall-cmd --permanent --add-port=56510/udp
sudo firewall-cmd --reload
```

## Ubuntu/Debian (ufw)

```bash
# Allow syslog port
sudo ufw allow 514/tcp

# Verify
sudo ufw status
```

## Arch Linux

Arch typically uses iptables or nftables. For iptables:

```bash
# Allow syslog port
sudo iptables -A INPUT -p tcp --dport 514 -j ACCEPT

# Make persistent (install iptables-persistent)
sudo systemctl enable iptables-persistent
```

## Verify Firewall Rules

### On syslog server:

```bash
# Check listening ports
sudo ss -tuln | grep 514

# Check firewall status
sudo firewall-cmd --list-all  # Fedora
sudo ufw status              # Ubuntu
sudo iptables -L INPUT -n    # Arch
```

### Test connectivity from client:

```bash
# Test TCP connection
nc -zv <server_ip> 514

# Or using bash
timeout 5 bash -c 'echo > /dev/tcp/<server_ip>/514' && echo "OK"
```

## Troubleshooting

### Client can't connect to server

1. Check if server is listening:
   ```bash
   sudo ss -tuln | grep 514
   ```

2. Check firewall on server:
   ```bash
   sudo firewall-cmd --list-all
   ```

3. Check if any firewall on client is blocking outgoing:
   ```bash
   sudo ss -tn | grep 514
   ```

4. Test with telnet/nc:
   ```bash
   nc -zv <server_ip> 514
   ```

### Connection times out

- Verify network connectivity: `ping <server_ip>`
- Check VPN is connected: `wg show`
- Check server IP is correct

### Connection refused

- Verify rsyslog/syslog-ng is running on server
- Check firewall rules allow port 514/tcp
