# PiHole with DoH

This was pieced together using [testdasi/pihole-with-doh](https://github.com/testdasi/pihole-with-doh) as the basis, but that project used a secondary internal Dockerfile as the base image.  I've taken what that project has done and put it into a single Dockerfile.  The official Docker Pi-Hole Docker image is combined with Cloudflared DoH client to enable DNS-over-HTTPS added to increase security and privacy. **This image is only for AMD64 machines.**

## Environment Variables

DNS_UPSTREAM: Comma separated list of upstream DNS servers to use.  The DNS Settings in Pi-Hole will have no effect since all DNS requests are routed over HTTPS. You can use `https://1.1.1.1/dns-query,https://1.0.0.1/dns-query` as the default settings to use Cloudfare's DNS servers or swap to `https://1.1.1.3/dns-query,https://1.0.0.3/dns-query` to use Cloudfare's servers for families which blocks adult content

[Docker Hub](https://hub.docker.com/r/themranderson/pi-hole-cloudfare-doh)

There is a Dependabot config to ensure as the PiHole base image is updated, this is as well to ensure this stays up to date with their security updates.
