FROM caddy:2-builder AS builder

RUN xcaddy build \
    --with github.com/pteich/caddy-tlsconsul \
    --with github.com/caddy-dns/cloudflare

FROM caddy:2-alpine

COPY --from=builder /usr/bin/caddy /usr/bin/caddy

RUN caddy version

EXPOSE 80 443 2019

CMD ["caddy", "run", "--config", "/etc/caddy/Caddyfile"]
