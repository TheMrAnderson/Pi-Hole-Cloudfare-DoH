#!/bin/bash

# Start cloudflared DoH proxy in background
cloudflared proxy-dns --port 5053 &
# Wait a moment to let cloudflared warm up
sleep 2
# Launch Pi-hole
/docker-entrypoint.sh
