# PiHole with DoH

This was pieced together using [testdasi/pihole-with-doh](https://github.com/testdasi/pihole-with-doh) as the basis, but that project used a secondary internal Dockerfile as the base image.  I've taken what that project has done and put it into a single Dockerfile.  The official Docker Pi-Hole Docker image is combined with Cloudflared DoH client to enable DNS-over-HTTPS added to increase security and privacy. **This image is only for AMD64 machines.**

## Environment Variables

DNS_UPSTREAM: Comma separated list of upstream DNS servers to use.  The DNS Settings in Pi-Hole will have no effect since all DNS requests are routed over HTTPS. You can use `https://1.1.1.1/dns-query,https://1.0.0.1/dns-query` as the default settings to use Cloudfare's DNS servers or swap to `https://1.1.1.3/dns-query,https://1.0.0.3/dns-query` to use Cloudfare's servers for families which blocks adult content

[Docker Hub](https://hub.docker.com/r/themranderson/pi-hole-cloudfare-doh)

## Update Automation

This repo now uses GitHub Actions (not Docker Hub autobuild) as the source of truth for updates:

1. `Dockerfile` pins `pihole/pihole` to a versioned tag (currently `2026.02.0`).
2. Dependabot opens PRs when that base image tag changes.
3. CI workflow builds and smoke-tests every PR.
4. Publish workflow runs on every push to `master`.
5. Publish workflow runs daily (`cron`) and skips builds unless the Pi-hole base image changed.
6. Publish workflow supports manual `workflow_dispatch`.
7. Publish workflow pushes Docker Hub tags.
8. Pushed tags include `latest`.
9. Pushed tags include `stable`.
10. Pushed tags include `pihole-<base-tag>`.
11. Pushed tags include `sha-<commit>`.

## Notifications

If the scheduled publish run fails, GitHub Actions opens (or updates) an issue titled `Scheduled Docker publish failed`. The issue is auto-closed after the next successful scheduled run.

To receive alerts without hunting:

1. Watch this repo with `Custom` notifications enabled for `Actions` and `Issues`.
2. Optionally enable email notifications for failed GitHub Actions workflow runs in your GitHub notification settings.
