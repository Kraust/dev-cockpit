# Development Cockpit

## Linux

### Standalone Docker

```bash
docker build -f Dockerfile_linux -t dev-cockpit:latest .
docker run --rm --privileged -it -v /var/run/docker.sock:/var/run/docker.sock --net host dev-cockpit:latest
```

### Docker Compose

Note, you may want to change environment and mounts to match your environment. This setup supports deploying containers in a docker-in-docker environment but be careful because docker-in-docker assumes volume mounts on the host and not in the child container.

```bash
docker compose up
```

## Windows

- TODO

## TODO

- Windows Dockerfile
- Powershell for Shell instead of Bash
