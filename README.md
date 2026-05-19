# Overleaf

Personal Overleaf (ShareLaTeX) deployment using Docker Swarm.

## Stack

- **Overleaf**: Custom image (`local/sharelatex-full:6.1.2`)
- **MongoDB**: `mongo:8.0` (replica set)
- **Redis**: `redis:6.2`

## Custom Image

The Docker image includes:
- TeX Live 2025 (updated from 2024)
- Additional packages: graphviz, gnuplot, inkscape, asymptote
- Python packages: latexminted, dot2tex
- Shell-escape enabled

```bash
# Build custom image
docker build -t local/sharelatex-full:6.1.2 .
```

## Deployment

```bash
# Create volumes
docker volume create --name OVERLEAF_SHARELATEX_DATA
docker volume create --name OVERLEAF_MONGO_DATA
docker volume create --name OVERLEAF_REDIS_DATA

# Create network
docker network create -d overlay swarm-net

# Deploy stack
PROXY_URL=overleaf.example.com docker stack deploy -c docker-stack.yaml overleaf
```

## Configuration

Set the `PROXY_URL` environment variable before deploying:
```bash
export PROXY_URL=overleaf.example.com
```