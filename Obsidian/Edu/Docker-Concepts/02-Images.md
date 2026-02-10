# Images

Creating and managing Docker images.

## What is an Image?

A read-only template with instructions for creating a container.

## Dockerfile

```dockerfile
# Comment
FROM ubuntu:22.04           # Base image
LABEL maintainer="you@example.com"

# Install dependencies
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy application files
COPY . .

# Install Python dependencies
RUN pip3 install --no-cache-dir -r requirements.txt

# Expose port
EXPOSE 8000

# Define environment variable
ENV NAME=World

# Command to run
CMD ["python3", "app.py"]
```

## Building Images

```bash
# Build from Dockerfile in current directory
docker build -t myapp:latest .

# Build with custom Dockerfile
docker build -t myapp:v1 -f Dockerfile.dev .

# Tag an image
docker tag myapp:latest myapp:v1.0
```

## Managing Images

```bash
# List images
docker images
docker images -a

# Search Docker Hub
docker search nginx

# Pull image
docker pull nginx:latest

# Remove image
docker rmi myapp:latest
docker rmi $(docker images -q)  # Remove all

# View image history
docker history myapp:latest
```

## Multi-stage Builds

```dockerfile
# Build stage
FROM golang:1.20 AS builder
WORKDIR /src
COPY . .
RUN go build -o /binary myapp

# Runtime stage
FROM alpine:latest
COPY --from=builder /binary /usr/local/bin/
CMD ["/usr/local/bin/myapp"]
```

## Related

- [[01-Introduction]] - Previous: Introduction
- [[03-Containers]] - Next: Containers
- [[06-Docker-Compose]] - Compose for multi-container

## Next Steps

Proceed to [[03-Containers]] to learn about running containers.
