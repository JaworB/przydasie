# Volumes

Managing persistent data in containers.

## Why Volumes?

Containers are ephemeral - data is lost when container stops.

## Volume Types

| Type | Description | Use Case |
|------|-------------|----------|
| **Volumes** | Managed by Docker, stored in host filesystem | Database data |
| **Bind Mounts** | Map host directory to container | Development files |
| **tmpfs** | Stored in host memory only | Sensitive data |

## Managing Volumes

```bash
# Create volume
docker volume create myvolume

# List volumes
docker volume ls

# Inspect volume
docker volume inspect myvolume

# Remove volume
docker volume rm myvolume

# Remove unused volumes
docker volume prune
```

## Using Volumes

```bash
# Mount volume
docker run -d -v myvolume:/data nginx

# Mount host directory (bind mount)
docker run -d -v /host/path:/container/path nginx

# Read-only mount
docker run -d -v /host/data:/data:ro nginx

# tmpfs mount (in memory)
docker run -d --tmpfs /run nginx
```

## Docker Compose with Volumes

```yaml
version: "3.8"
services:
  web:
    image: nginx
    volumes:
      - web-data:/var/www/html
      - ./local:/etc/nginx/conf.d

  db:
    image: mysql
    volumes:
      - mysql-data:/var/lib/mysql

volumes:
  web-data:
  mysql-data:
```

## Related

- [[04-Networking]] - Previous: Networking
- [[06-Docker-Compose]] - Next: Docker Compose
- [[07-Files-IO]] in [[Python-Concepts]] - File I/O concepts

## Next Steps

Proceed to [[06-Docker-Compose]] to learn about multi-container applications.
