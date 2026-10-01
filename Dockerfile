# Keep the Pi-hole image directly in the FROM instruction so Dependabot can
# discover and update this dependency. Docker image references supplied via
# ARG are not updated by Dependabot.
FROM pihole/pihole:2026.09.0

# These values are supplied by the publish workflow for image provenance.
ARG PIHOLE_BASE_TAG=2026.09.0
ARG PIHOLE_BASE_IMAGE_ID

LABEL org.opencontainers.image.base.tag="${PIHOLE_BASE_TAG}" \
	org.opencontainers.image.base.image.id="${PIHOLE_BASE_IMAGE_ID}"

# Download cloudflared into the Pi-hole image.
RUN apt-get update && \
	apt-get install -y --no-install-recommends curl ca-certificates && \
	curl -L https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 -o /usr/local/bin/cloudflared && \
	chmod +x /usr/local/bin/cloudflared && \
	rm -rf /var/lib/apt/lists/*

# Create a user (optional security step)
RUN useradd -r -s /bin/false cloudflared

# Create directory for cloudflared config
RUN mkdir -p /etc/cloudflared

# Copy config and startup script
COPY cloudfared.yml /etc/cloudflared/config.yml
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Cloudflared DNS-over-HTTPS port
EXPOSE 5053/udp

CMD ["/start.sh"]

HEALTHCHECK --interval=30s --timeout=10s --start-period=10s \
	CMD pgrep pihole-FTL >/dev/null || exit 1
