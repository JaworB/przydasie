# Introduction

Understanding containers and Docker fundamentals.

## What are Containers?

**Containers** are lightweight, standalone, executable software packages that include everything needed to run the code.

## Containers vs VMs

| Aspect | Containers | Virtual Machines |
|--------|-------------|-----------------|
| Isolation | Process-level | Full OS emulation |
| Size | MBs | GBs |
| Startup | Seconds | Minutes |
| Overhead | Low | Higher |
| Guest OS | Host OS only | Any OS |

```
┌─────────────────────────────────────────────────┐
│                 Host OS                         │
│  ┌─────────┐  ┌─────────┐  ┌─────────┐         │
│  │Container│  │Container│  │Container│         │
│  │   App1  │  │   App2  │  │   App3  │         │
│  └─────────┘  └─────────┘  └─────────┘         │
│     ▲            ▲            ▲                   │
│     │ Docker Engine / Container Runtime           │
└─────│────────────────────────────────────────────┘
      │
      ▼
┌─────────────────────────────────────────────────┐
│           Hardware Infrastructure                │
└─────────────────────────────────────────────────┘
```

## What is Docker?

- Platform for developing, shipping, running applications
- Standardizes application packaging
- Docker Engine runs containers
- Docker Hub (registry) shares images

## Basic Concepts

| Term | Description |
|------|-------------|
| **Image** | Read-only template for creating containers |
| **Container** | Runnable instance of an image |
| **Dockerfile** | Script for building images |
| **Registry** | Storage for images (Docker Hub) |
| **Volume** | Persistent data storage |

## Installing Docker

```bash
# Ubuntu
sudo apt update
sudo apt install docker.io
sudo systemctl enable --now docker

# Add user to docker group
sudo usermod -aG docker $USER

# Verify
docker --version
docker run hello-world
```

## Related

- [[02-Images]] - Next: Docker Images
- [[03-Containers]] - Containers

## Next Steps

Proceed to [[02-Images]] to learn about Docker images.
