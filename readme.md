## PiHole with DoH

This was pieced together using [testdasi/pihole-with-doh](https://github.com/testdasi/pihole-with-doh) as the basis, but that project used a secondary internal Dockerfile as the base image and I've taken what that project has done and put it into a single Dockerfile that pulls directly from the official PiHole Docker hub to allow updates to happen by just stopping and starting the container.
