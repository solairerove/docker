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

RUN apt-get install -y \
        git \
        openssh-server \
        openssh-client \
        nano \
        curl \
	software-properties-common \
	python-software-properties

RUN \
  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update && \
  apt-get install -y oracle-java8-installer && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /var/cache/oracle-jdk8-installer

RUN rm -rf /var/lib/apt/lists/*

RUN apt-get clean

WORKDIR /data

ENV JAVA_HOME=/usr/lib/jvm/jdk1.8.0_91

CMD ["bash"]
