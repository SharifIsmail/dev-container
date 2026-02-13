# dev-container

Multi-AI CLI dev environment in a single Docker container with web terminals.

## Services

| Port | Service |
|------|---------|
| 7682 | bash (ttyd) |
| 7683 | claude (ttyd) |
| 7684 | gemini (ttyd) |
| 7685 | codex (ttyd) |
| 7686 | opencode (ttyd) |
| 8080 | VS Code (web) |

## Quick start

### Linux (or WSL2 with --network host)

```bash
docker run -d --network host \
  -e BIND_ADDR=127.0.0.1 \
  -e TTYD_CREDENTIAL=user:changeme \
  -v ./home:/home/ubuntu \
  ghcr.io/sharifismail/dev-container:latest
```

### Windows / Docker Desktop

```bash
docker run -d \
  -p 7682:7682 -p 7683:7683 -p 7684:7684 \
  -p 7685:7685 -p 7686:7686 -p 8080:8080 \
  -e TTYD_CREDENTIAL=user:changeme \
  -v dev-home:/home/ubuntu \
  ghcr.io/sharifismail/dev-container:latest
```

## Build locally

```bash
cp .env.example .env   # edit credentials
docker compose up -d --build
```
