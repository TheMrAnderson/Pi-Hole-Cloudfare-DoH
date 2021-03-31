## PiHole with DoH

This was pieced together using [testdasi/pihole-with-doh](https://github.com/testdasi/pihole-with-doh) as the basis, but that project used a secondary internal Dockerfile as the base image.  I've taken what that project has done and put it into a single Dockerfile.  The official Docker Pi-Hole Docker image is combined with Cloudflared DoH client to enable DNS-over-HTTPS added to increase security and privacy. **This image is only for AMD64 machines.**

[Docker Hub](https://hub.docker.com/r/themranderson/pi-hole-cloudfare-doh)
