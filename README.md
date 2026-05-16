# Overleaf

Personal Overleaf (ShareLaTeX) deployment using Docker Swarm.

## Stack

- **Overleaf**: `sharelatex/sharelatex:6.1.2`
- **MongoDB**: `mongo:8.0` (replica set)
- **Redis**: `redis:6.2`

## Deployment

```bash
# Create volumes
docker volume create --name OVERLEAF_SHARELATEX_DATA
docker volume create --name OVERLEAF_MONGO_DATA
docker volume create --name OVERLEAF_REDIS_DATA

# Create network
docker network create -d overlay swarm-net

# Deploy stack
docker stack deploy -c docker-stack.yaml overleaf
```

## Configuration

Set the `PROXY_URL` environment variable before deploying:
```bash
export PROXY_URL=overleaf.example.com
```