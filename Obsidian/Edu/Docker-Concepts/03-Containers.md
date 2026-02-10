# Containers

Running and managing Docker containers.

## Running Containers

```bash
# Run container
docker run nginx

# Run in detached mode (background)
docker run -d nginx

# Run with name
docker run -d --name mynginx nginx

# Run and remove after exit
docker run --rm nginx

# Interactive container
docker run -it ubuntu bash

# Run with port mapping
docker run -d -p 8080:80 nginx
# Host:8080 → Container:80
```

## Container Lifecycle

```bash
# Start stopped container
docker start mynginx

# Stop running container
docker stop mynginx

# Restart container
docker restart mynginx

# Pause/unpause
docker pause mynginx
docker unpause mynginx

# Kill (force stop)
docker kill mynginx
```

## Managing Containers

```bash
# List running containers
docker ps

# List all containers (including stopped)
docker ps -a

# View container logs
docker logs mynginx
docker logs -f mynginx  # Follow

# View container processes
docker top mynginx

# Inspect container details
docker inspect mynginx

# View container stats
docker stats mynginx
```

## Executing Commands in Container

```bash
# Run command in running container
docker exec mynginx ls /usr/share/nginx/html

# Interactive shell
docker exec -it mynginx bash
```

## Copying Files

```bash
# Copy from host to container
docker cp file.txt mynginx:/app/file.txt

# Copy from container to host
docker cp mynginx:/app/data.txt ./data.txt
```

## Related

- [[02-Images]] - Previous: Images
- [[04-Networking]] - Next: Networking
- [[05-Volumes]] - Data persistence

## Next Steps

Proceed to [[04-Networking]] to learn about container networking.
