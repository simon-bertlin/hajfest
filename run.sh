podman stop hajfest
podman rm hajfest
podman stop hajfest-caddy 
podman rm hajfest-caddy 

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