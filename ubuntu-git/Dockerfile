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
        curl

RUN rm -rf /var/lib/apt/lists/*

# download oracle jdk
RUN curl -L -b "oraclelicense=a" http://download.oracle.com/otn-pub/java/jdk/8u91-b14/jdk-8u91-linux-x64.tar.gz -O

# create dir, unzip jdk and delete archive
RUN mkdir -p /usr/lib/jvm
RUN tar -xf jdk-8u91-linux-x64.tar.gz -C /usr/lib/jvm
RUN rm jdk-8u91-linux-x64.tar.gz

# update-alternatives
RUN update-alternatives --install /usr/lib/javac javac /usr/lib/jvm/jdk1.8.0_91/bin/javac 1
RUN update-alternatives --install /usr/lib/java java /usr/lib/jvm/jdk1.8.0_91/bin/java 1
RUN update-alternatives --config javac
RUN update-alternatives --config java

# export env variables
#RUN touch /etc/profile.d/variables.sh
#RUN echo export JAVA_HOME=/usr/lib/jvm/jdk1.8.0_91 >> /etc/profile.d/variables.sh
#RUN echo export PATH=$JAVA_HOME/bin:$PATH >> /etc/profile.d/variables.sh

ENV JAVA_HOME=/usr/lib/jvm/jdk1.8.0_91

RUN apt-get clean

