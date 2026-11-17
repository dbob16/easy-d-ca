#!/bin/sh

if [ -x "$(command -v docker)" ]; then
docker run -d -p 80:80 -p 443:443 \
  --env-file ./.env \
  --restart=always \
  -v ./test:/sitefiles:ro \
  -v ./Caddyfile:/etc/caddy/Caddyfile \
  -v ./caddyfiles:/caddyfiles:ro \
  caddy:latest
elif [ -x "$(command -v podman)" ]; then
  podman run -d -p 80:80 -p 443:443 \
    --env-file ./.env \
    --restart=always \
    -v ./test:/sitefiles:ro \
    -v ./Caddyfile:/etc/caddy/Caddyfile \
    -v ./caddyfiles:/caddyfiles:ro \
    caddy:latest
fi
