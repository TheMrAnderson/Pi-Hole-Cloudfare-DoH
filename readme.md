## PiHole with DoH

This was pieced together using [testdasi/pihole-with-doh](https://github.com/testdasi/pihole-with-doh) as the basis, but that project used a secondary internal Dockerfile as the base image and I've taken what that project has done and put it into a single Dockerfile that pulls directly from the official PiHole Docker hub to allow updates to happen by just stopping and starting the container.

The official Docker Pi-Hole Docker image with Cloudflared DoH client to enable DNS-over-HTTPS added to increase security and privacy. This image is only for AMD64 machines so it matches my use case.
