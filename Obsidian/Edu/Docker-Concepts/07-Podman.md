# Podman

Docker alternative for container management.

## What is Podman?

- Daemonless container engine
- Pod-based architecture (like Kubernetes)
- Runs containers without root by default
- Drop-in replacement for Docker CLI

## Installing Podman

```bash
# Ubuntu/Debian
. /etc/os-release
echo "deb https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_${VERSION_ID}/ /" | \
    sudo tee /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list
sudo apt-get update
sudo apt-get install podman

# Verify
podman --version
```

## Basic Commands

```bash
# Run container (same syntax as Docker)
podman run -d --name mynginx -p 8080:80 nginx

# List containers
podman ps

# Stop/start
podman stop mynginx
podman start mynginx

# View logs
podman logs mynginx

# Remove container
podman rm mynginx
```

## Images

```bash
# Build image
podman build -t myapp:latest .

# List images
podman images

# Pull image
podman pull nginx:latest

# Remove image
podman rmi myapp:latest
```

## Pods (Podman Unique Feature)

```bash
# Create pod
podman pod create --name mypod

# Run container in pod
podman run -d --pod mypod nginx

# List pods
podman pod ls

# Manage pod
podman pod stop mypod
podman pod rm mypod
```

## Docker Compatibility

```bash
# Use Docker alias for Podman
alias docker=podman

# Or configure Docker socket (systemd)
sudo loginctl enable-linger $USER
```

## Rootless Containers

```bash
# No root required by default
# Podman uses user namespaces
# Runs containers as regular user

# Create systemd service (rootless)
podman generate systemd --name mycontainer > mycontainer.service
```

## Related

- [[06-Docker-Compose]] - Previous: Docker Compose
- [[08-Containerization]] - Next: Best Practices
- [[01-Introduction]] - Container fundamentals

## Next Steps

Proceed to [[08-Containerization]] to learn about security best practices.
