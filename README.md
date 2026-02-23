# Hajfest

Simple webpage for the hajfest.

## Build

```bash
podman build -t hajfest .
```

## Podman network

```bash
podman network create hajnet
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

### Run Caddy, for https

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

## Run everything
```bash
podman network create hajnet

podman run -d \
  --name hajfest \
  --network hajnet \
  --restart unless-stopped \
  hajfest

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

## Stop everything
```bash
podman stop hajfest
podman rm hajfest
podman stop hajfest-caddy 
podman rm hajfest-caddy 
```

## Start on boot

Make sure to change the directory of the caddyfile if needed.

```bash
podman generate systemd --new --name hajfest --files
podman generate systemd --new --name hajfest-caddy --files
mv container-hajfest.service container-hajfest-caddy.service ~/.config/systemd/user/
systemctl --user daemon-reload
systemctl --user enable container-hajfest.service container-hajfest-caddy.service
```