# Development Cockpit

## Linux

```bash
docker build -f Dockerfile_linux -t dev-cockpit:latest .
docker compose up -d
```

Then connect with Neovide:

```bash
neovide --server 127.0.0l.1:9999 --no-multigrid
```


## Windows

- TODO

## TODO

- Windows Dockerfile
