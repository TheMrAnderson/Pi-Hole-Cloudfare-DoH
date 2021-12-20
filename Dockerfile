FROM pihole/pihole:master

# Install needed packages
RUN apt-get update && apt-get install -y \
	apt-utils \
	stubby \
	wget \
	&& mkdir -p /etc/stubby \
	&& rm -f /etc/stubby/stubby.yml \
	&& rm -rf /var/lib/apt/lists/*

# add cloudflared config
COPY ./cloudfared cloudfared

# install cloudflared
RUN cd /tmp \
	&& wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb \
	&& apt install ./cloudflared-linux-amd64.deb \
	&& rm -f ./cloudflared-linux-amd64.deb \
	&& useradd -s /usr/sbin/nologin -r -M cloudflared \
	&& chown cloudflared:cloudflared /usr/local/bin/cloudflared \
	&& mkdir -p /etc/cloudflared \
	&& rm -f /etc/cloudflared/config.yml
