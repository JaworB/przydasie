# Cheatsheet

Quick Docker and Podman command reference.

## Docker Commands

### Images

| Command | Description |
|---------|-------------|
| `docker build -t name:tag .` | Build image |
| `docker images` | List images |
| `docker rmi name:tag` | Remove image |
| `docker pull name:tag` | Pull from registry |
| `docker tag src dest` | Tag image |

### Containers

| Command | Description |
|---------|-------------|
| `docker run -d -p 8080:80 name` | Run container |
| `docker run -it name bash` | Interactive shell |
| `docker ps` | List running containers |
| `docker ps -a` | List all containers |
| `docker stop name` | Stop container |
| `docker start name` | Start container |
| `docker rm name` | Remove container |
| `docker logs name` | View logs |
| `docker exec -it name bash` | Execute command |
| `docker inspect name` | Container details |

### Volumes

| Command | Description |
|---------|-------------|
| `docker volume create name` | Create volume |
| `docker volume ls` | List volumes |
| `docker volume rm name` | Remove volume |

### Networks

| Command | Description |
|---------|-------------|
| `docker network ls` | List networks |
| `docker network create name` | Create network |

### Docker Compose

| Command | Description |
|---------|-------------|
| `docker-compose up -d` | Start services |
| `docker-compose down` | Stop services |
| `docker-compose logs -f` | View logs |
| `docker-compose build` | Rebuild images |

---

## Podman Commands

| Docker | Podman | Description |
|--------|--------|-------------|
| `docker run` | `podman run` | Run container |
| `docker ps` | `podman ps` | List containers |
| `docker images` | `podman images` | List images |
| `docker build` | `podman build` | Build image |
| `docker-compose` | `podman-compose` | Compose files |

---

## Common Patterns

### Development

```bash
# Mount source code for hot reload
docker run -v $(pwd):/app -p 3000:3000 node:alpine npm run dev
```

### Database

```bash
# Persistent MySQL
docker run -d -v mysql-data:/var/lib/mysql \
  -e MYSQL_ROOT_PASSWORD=secret \
  mysql:8
```

### Nginx Reverse Proxy

```bash
docker run -d -p 80:80 -p 443:443 \
  -v nginx-data:/etc/nginx \
  nginx:alpine
```

---

## Related

- [[01-Introduction]] - Return to Introduction
- [[08-Containerization]] - Best Practices
- [[index]] - Docker Concepts Index

## Return to [[index]]
