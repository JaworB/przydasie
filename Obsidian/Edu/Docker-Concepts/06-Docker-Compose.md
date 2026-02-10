# Docker Compose

Managing multi-container applications.

## What is Docker Compose?

Tool for defining and running multi-container applications with YAML configuration.

## docker-compose.yml

```yaml
version: "3.8"

services:
  web:
    image: nginx:alpine
    ports:
      - "8080:80"
    volumes:
      - web-data:/var/www/html
    depends_on:
      - db
    networks:
      - app-network
    restart: unless-stopped

  db:
    image: mysql:8
    environment:
      MYSQL_ROOT_PASSWORD: rootpass
      MYSQL_DATABASE: appdb
    volumes:
      - mysql-data:/var/lib/mysql
    networks:
      - app-network
    restart: unless-stopped

  redis:
    image: redis:alpine
    networks:
      - app-network
    restart: unless-stopped

volumes:
  web-data:
  mysql-data:

networks:
  app-network:
    driver: bridge
```

## Commands

```bash
# Start services
docker-compose up

# Start detached
docker-compose up -d

# Stop services
docker-compose down

# Stop and remove volumes
docker-compose down -v

# View logs
docker-compose logs
docker-compose logs -f

# Rebuild images
docker-compose build

# Scale services
docker-compose up -d --scale web=3
```

## Environment Variables

```yaml
services:
  web:
    image: nginx
    env_file:
      - .env
    environment:
      - NODE_ENV=production
      - DEBUG=${DEBUG:-false}
```

## Override File

```bash
# Use different compose file
docker-compose -f docker-compose.yml -f docker-compose.prod.yml up
```

## Related

- [[05-Volumes]] - Previous: Volumes
- [[07-Podman]] - Next: Podman
- [[Docker]] in scripts - Example compose files

## Next Steps

Proceed to [[07-Podman]] to learn about Podman as Docker alternative.
