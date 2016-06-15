FROM ubuntu:14.04

MAINTAINER "Nikita Krivitski" <hax2033@gmail.com>

# Fuck off from complaining
RUN dpkg-divert --local --rename --add /sbin/initctl
RUN ln -sf /bin/true /sbin/initctl

# Let the container know that there is no tty
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update

RUN echo "#!/bin/sh\nexit 0" > /usr/sbin/policy-rc.d
RUN apt-get upgrade -y

RUN apt-get install -y ca-certificates inotify-tools pwgen supervisor unzip wget python-setuptools

RUN sed -i 's/^\(\[supervisord\]\)$/\1\nnodaemon=true/' /etc/supervisor/supervisord.conf

RUN useradd -u 1000 webapps

# Create base path
RUN mkdir /config /data

RUN apt-get install -y \
	git \
	openssh-server \
	openssh-client \
	nano \
&& rm -rf /var/lib/apt/lists/*

RUN apt-get clean

ADD config /config
RUN chmod +x /config/loop.sh
CMD ["/config/loop.sh"]
