FROM pihole/pihole:master-buster:latest-amd64

# install basic packages
RUN apt-get update && apt-get install -y \
	dist-upgrade \
	sudo \
	bash \
	nano \
	stubby

# clean stubby config
RUN mkdir -p /etc/stubby \
	&& rm -f /etc/stubby/stubby.yml

# install cloudflared
RUN cd /tmp \
	&& wget https://bin.equinox.io/c/VdrWdbjqyF/cloudflared-stable-linux-amd64.deb \
	&& apt install ./cloudflared-stable-linux-amd64.deb \
	&& rm -f ./cloudflared-stable-linux-amd64.deb

RUN useradd -s /usr/sbin/nologin -r -M cloudflared \
	&& chown cloudflared:cloudflared /usr/local/bin/cloudflared

# clean cloudflared config
RUN mkdir -p /etc/cloudflared \
	&& rm -f /etc/cloudflared/config.yml

# clean up
RUN apt-get -y autoremove \
	&& apt-get -y autoclean \
	&& apt-get -y clean \
	&& rm -fr /tmp/* /var/tmp/* /var/lib/apt/lists/*

# add cloudflared config
ADD cloudflared /tmp