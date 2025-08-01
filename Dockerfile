# Stage 1: Download cloudflared binary
FROM debian:bullseye AS cloudflared-builder

RUN apt-get update && \
	apt-get install -y curl && \
	curl -L https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 -o /cloudflared && \
	chmod +x /cloudflared

# Stage 2: Use Pi-hole base image
FROM pihole/pihole:latest

# Copy cloudflared into Pi-hole image
COPY --from=cloudflared-builder /cloudflared /usr/local/bin/cloudflared

# Create a user (optional security step)
RUN useradd -r -s /bin/false cloudflared

# Create directory for cloudflared config
RUN mkdir -p /etc/cloudflared

# Copy config and startup script
COPY cloudflared/config.yml /etc/cloudflared/config.yml
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Cloudflared DNS-over-HTTPS port
EXPOSE 5053/udp

CMD ["/start.sh"]

HEALTHCHECK --interval=30s --timeout=10s --start-period=10s \
	CMD curl -sSf http://localhost/admin/index.php || exit 1
