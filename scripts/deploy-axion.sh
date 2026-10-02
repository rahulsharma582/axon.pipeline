#!/usr/bin/env bash
set -euo pipefail

ACR_LOGIN_SERVER="${1:?ACR login server required}"
IMAGE_TAG="${2:?Image tag required}"
CONTAINER_PORT="${3:-8080}"

IMAGE="${ACR_LOGIN_SERVER}/axion:${IMAGE_TAG}"

az login --identity --allow-no-subscriptions >/dev/null
az acr login --name "${ACR_LOGIN_SERVER%%.*}" >/dev/null

docker pull "${IMAGE}"
docker rm -f axion >/dev/null 2>&1 || true

docker run -d \
  --name axion \
  --restart unless-stopped \
  -p "${CONTAINER_PORT}:${CONTAINER_PORT}" \
  --health-cmd="curl -fsS http://127.0.0.1:${CONTAINER_PORT}/health || exit 1" \
  --health-interval=30s \
  --health-timeout=5s \
  --health-retries=3 \
  "${IMAGE}"

docker image prune -af --filter "until=168h" || true
sleep 5
curl -fsS "http://127.0.0.1:${CONTAINER_PORT}/health"
