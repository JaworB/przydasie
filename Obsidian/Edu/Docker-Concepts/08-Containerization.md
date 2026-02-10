# Containerization

Best practices for secure and efficient containers.

## Security Best Practices

### 1. Use Specific Image Tags

```dockerfile
# Avoid
FROM nginx        # Could change unexpectedly

# Good
FROM nginx:1.25-alpine  # Specific version
FROM node:20-alpine3.18
```

### 2. Don't Run as Root

```dockerfile
# Create user
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser
```

### 3. Minimize Image Size

```dockerfile
# Use Alpine-based images
FROM node:20-alpine

# Multi-stage builds
FROM golang:1.20 AS builder
WORKDIR /src
COPY . .
RUN go build -o /binary

FROM alpine:latest
COPY --from=builder /binary /usr/local/bin/
CMD ["/usr/local/bin/myapp"]
```

### 4. Don't Include Secrets

```dockerfile
# BAD - secrets in image
ENV API_KEY=secret123

# GOOD - pass at runtime
docker run -e API_KEY=$API_KEY myapp
```

### 5. Health Checks

```dockerfile
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:8080/health || exit 1
```

## Efficiency Tips

### Build Cache

```dockerfile
# Copy dependency files first
COPY package*.json ./
RUN npm ci

# Copy application files
COPY . .
```

### Layer Ordering

```dockerfile
# Order from least to most frequently changing:
# 1. System dependencies
# 2. Application dependencies
# 3. Source code
```

## Container Best Practices Checklist

- [x] Use specific version tags
- [x] Run as non-root user
- [x] Use multi-stage builds
- [x] Don't embed secrets
- [x] Add health checks
- [x] Use .dockerignore
- [x] Scan images for vulnerabilities
- [x] Keep images small (Alpine)
- [x] Use labels for metadata
- [x] Document exposed ports

## .dockerignore

```
.git
node_modules
.env
*.log
Dockerfile
.dockerignore
README.md
```

## Labels

```dockerfile
LABEL maintainer="you@example.com"
LABEL version="1.0.0"
LABEL description="My application"
```

## Scanning Images

```bash
# Trivy (open source)
trivy image myapp:latest

# Hadolint (Dockerfile linting)
hadolint Dockerfile
```

## Related

- [[07-Podman]] - Previous: Podman
- [[09-Cheatsheet]] - Next: Quick Reference
- [[03-Securing-Data]] in [[Git-Concepts/Git-GitHub-Workflow]] - Securing secrets

## Next Steps

Proceed to [[09-Cheatsheet]] for a quick command reference.
