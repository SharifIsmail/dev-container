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

```bash
docker run -d --network host \
  -e TTYD_CREDENTIAL=user:changeme \
  -v ./home:/home/ubuntu \
  ghcr.io/sharifismail/dev-container:latest
```

## Build locally

```bash
cp .env.example .env   # edit credentials
docker compose up -d --build
```
