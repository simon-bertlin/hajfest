# Hajfest

Simple webpage for the hajfest.

## Build

```bash
podman build -t hajfest .
```

## Run

```bash
podman run -d \
  --name hajfest \
  --network hajnet \
  --restart unless-stopped \
  hajfest
```

Site available at: http://localhost:8080

## Stop & Remove

```bash
podman stop hajfest
podman rm hajfest
```

## Rebuild and run

```bash
podman stop hajfest
podman rm hajfest
podman build -t hajfest .
podman run -d -p 8080:80 --name hajfest hajfest
```

## HTTPS

```bash
podman network create hajnet
```

### Run Caddy

```bash
podman run -d \
  --name hajfest-caddy \
  --network hajnet \
  --dns 8.8.8.8 \
  -p 80:80 \
  -p 443:443 \
  -v ./Caddyfile:/etc/caddy/Caddyfile:Z \
  -v caddy_data:/data \
  --restart unless-stopped \
  docker.io/caddy:alpine
```

### Stop & Remove

```bash
podman stop hajfest-caddy 
podman rm hajfest-caddy 
```