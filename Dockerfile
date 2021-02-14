FROM pihole/pihole:master-buster

# Install needed packages
RUN apt-get update && apt-get install -y \
	apt-utils \
	stubby \
	&& mkdir -p /etc/stubby \
	&& rm -f /etc/stubby/stubby.yml

# add cloudflared config
COPY ./cloudfared cloudfared

# install cloudflared
RUN cd /tmp \
	&& wget https://bin.equinox.io/c/VdrWdbjqyF/cloudflared-stable-linux-amd64.deb \
	&& apt install ./cloudflared-stable-linux-amd64.deb \
	&& rm -f ./cloudflared-stable-linux-amd64.deb \
	&& useradd -s /usr/sbin/nologin -r -M cloudflared \
	&& chown cloudflared:cloudflared /usr/local/bin/cloudflared \
	&& mkdir -p /etc/cloudflared \
	&& rm -f /etc/cloudflared/config.yml \
	&& apt-get -y autoremove \
	&& apt-get -y autoclean \
	&& apt-get -y clean \
	&& rm -fr /tmp/* /var/tmp/* /var/lib/apt/lists/* \
	&& mv /tmp /cloudfared