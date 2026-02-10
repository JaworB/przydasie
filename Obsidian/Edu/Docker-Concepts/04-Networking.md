# Networking

Container networking and port mapping.

## Port Mapping

```bash
# Map host port to container port
docker run -d -p 8080:80 nginx
# Format: host:container

# Map specific host IP
docker run -d -p 127.0.0.1:8080:80 nginx

# Random host port
docker run -d -P nginx  # Docker assigns random port

# List port mappings
docker port mynginx
```

## Network Types

| Network | Description |
|---------|-------------|
| **bridge** | Default, container-to-container on same host |
| **host** | Share host's network namespace |
| **none** | No networking |
| **overlay** | Multi-host networking (Swarm) |

## Managing Networks

```bash
# List networks
docker network ls

# Create network
docker network create mynetwork

# Connect container to network
docker network connect mynetwork mycontainer

# Disconnect
docker network disconnect mynetwork mycontainer

# Remove network
docker network rm mynetwork

# Inspect network
docker network inspect bridge
```

## Bridge Network Example

```bash
# Create custom bridge network
docker network create app-network

# Run containers on same network
docker run -d --network app-network --name db mysql
docker run -d --network app-network --name web nginx

# Containers can communicate by name
# web can reach db
```

## DNS and Service Discovery

```bash
# Containers on same network can resolve each other by name
docker run --network mynetwork alpine ping db  # Resolves 'db' container IP
```

## Related

- [[03-Containers]] - Previous: Containers
- [[05-Volumes]] - Next: Volumes
- [[12-Remotes]] in [[Git-Concepts]] - Remote networking concepts

## Next Steps

Proceed to [[05-Volumes]] to learn about data persistence.
