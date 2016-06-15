FROM ubuntu:14.04

MAINTAINER "Nikita Krivitski" <hax2033@gmail.com>

# fuck off from complaining
RUN dpkg-divert --local --rename --add /sbin/initctl
RUN ln -sf /bin/true /sbin/initctl

# let the container know that there is no tty
ENV DEBIAN_FRONTEND noninteractive

# update
RUN apt-get update
RUN echo "#!/bin/sh\nexit 0" > /usr/sbin/policy-rc.d
RUN apt-get upgrade -y

RUN apt-get install -y ca-certificates inotify-tools pwgen supervisor unzip wget python-setuptools
RUN sed -i 's/^\(\[supervisord\]\)$/\1\nnodaemon=true/' /etc/supervisor/supervisord.conf
RUN useradd -u 1000 webapps

# install needed soft
RUN apt-get install -y \
        git \
        openssh-server \
        openssh-client \
        nano \
        curl \
	software-properties-common \
	python-software-properties

# jdk 8
RUN \
  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update && \
  apt-get install -y oracle-java8-installer && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /var/cache/oracle-jdk8-installer

ENV JAVA_HOME=/usr/lib/jvm/jdk1.8.0_91/jre

# maven 3.3.9
ENV MAVEN_VERSION 3.3.9

RUN mkdir -p /usr/share/maven /usr/share/maven/ref \
  && curl -fsSL http://apache.osuosl.org/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz \
    | tar -xzC /usr/share/maven --strip-components=1 \
  && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

ENV MAVEN_HOME=/usr/share/maven
ENV MAVEN_CONFIG /root/.m2
ENV COPY_REFERENCE_FILE_LOG $MAVEN_CONFIG copy_reference_file.log

COPY mvn-entrypoint.sh /usr/local/bin/mvn-entrypoint.sh
COPY settings-docker.xml /usr/share/maven/ref/

VOLUME /root/.m2

ENTRYPOINT ["/usr/local/bin/mvn-entrypoint.sh"]
CMD ["mvn"]

# clean
RUN rm -rf /var/lib/apt/lists/*
RUN apt-get clean

WORKDIR /data

CMD ["bash"]
