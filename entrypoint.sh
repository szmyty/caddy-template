#!/bin/sh

# Formats the Caddyfile.
# https://caddyserver.com/docs/command-line#caddy-fmt
caddy fmt --overwrite /etc/caddy/Caddyfile

# Runs Caddy and blocks indefinitely; i.e. "daemon" mode.
# https://caddyserver.com/docs/command-line#caddy-run
caddy run --config /etc/caddy/Caddyfile --adapter caddyfile