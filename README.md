# Development Cockpit

## Linux

### Standalone Docker

```bash
docker build -f Dockerfile_linux -t dev-cockpit:latest .
docker run --rm --privileged -it -v /var/run/docker.sock:/var/run/docker.sock --net host dev-cockpit:latest
```

### Docker Compose

- TBD

## Windows

- TODO

## TODO

- Docker Compose
- Copy SSH Keys In
- Windows Dockerfile
