# Hajfest

Simple webpage for the hajfest.

## Build

```bash
podman build -t hajfest .
```

## Run

```bash
podman run -d -p 8080:80 --name hajfest hajfest
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
