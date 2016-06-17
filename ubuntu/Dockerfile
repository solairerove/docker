FROM ubuntu:14.04

MAINTAINER "Nikita Krivitski" <hax2033@gmail.com>

# set versions
ENV DEBIAN_FRONTEND noninteractive
ENV MAVEN_VERSION 3.3.9
ENV TOMCAT_VERSION 8.0.35

# fuck off from complaining
RUN dpkg-divert --local --rename --add /sbin/initctl
RUN ln -sf /bin/true /sbin/initctl
RUN echo "#!/bin/sh\nexit 0" > /usr/sbin/policy-rc.d

# install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
        git \
        openssh-server \
        openssh-client \
        nano \
        curl \
	wget \
	unzip \
	software-properties-common \
	python-software-properties \
	supervisor

RUN sed -i 's/^\(\[supervisord\]\)$/\1\nnodaemon=true/' /etc/supervisor/supervisord.conf
RUN useradd -u 1000 webapps

# install jdk 8
RUN \
  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update && \
  apt-get install -y oracle-java8-installer && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /var/cache/oracle-jdk8-installer

ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

# install maven 3.3.9
RUN mkdir -p /usr/share/maven /usr/share/maven/ref \
  && curl -fsSL http://apache.osuosl.org/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz \
    | tar -xzC /usr/share/maven --strip-components=1 \
  && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

ENV MAVEN_HOME /usr/share/maven
ENV MAVEN_CONFIG /root/.m2
ENV COPY_REFERENCE_FILE_LOG $MAVEN_CONFIG copy_reference_file.log

VOLUME /root/.m2

CMD ["mvn"]

# install tomcat 8
RUN wget --quiet --no-cookies http://apache.rediris.es/tomcat/tomcat-8/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz -O /tmp/tomcat.tgz && \
tar xzvf /tmp/tomcat.tgz -C /opt && \
mv /opt/apache-tomcat-${TOMCAT_VERSION} /opt/tomcat && \
rm /tmp/tomcat.tgz && \
rm -rf /opt/tomcat/webapps/examples && \
rm -rf /opt/tomcat/webapps/docs && \
rm -rf /opt/tomcat/webapps/ROOT

ENV CATALINA_HOME /opt/tomcat
ENV PATH $PATH:$CATALINA_HOME/bin

EXPOSE 8080
EXPOSE 8009
VOLUME "/opt/tomcat/webapps"

# install liferay
RUN curl -O -s -k -L -C - http://downloads.sourceforge.net/project/lportal/Liferay%20Portal/6.2.3%20GA4/liferay-portal-tomcat-6.2-ce-ga4-20150416163831865.zip \
	&& unzip liferay-portal-tomcat-6.2-ce-ga4-20150416163831865.zip -d /opt \
	&& rm liferay-portal-tomcat-6.2-ce-ga4-20150416163831865.zip

# add config for bdd
RUN /bin/echo -e '\nCATALINA_OPTS="$CATALINA_OPTS -Dexternal-properties=portal-bd-${DB_TYPE}.properties"' >> /opt/liferay-portal-6.2-ce-ga4/tomcat-7.0.42/bin/setenv.sh

# add configuration liferay file
# ADD lep/portal-bundle.properties /opt/liferay-portal-6.2-ce-ga4/portal-bundle.properties

# clean
RUN rm -rf /var/lib/apt/lists/*
RUN apt-get clean

WORKDIR /data
CMD ["bash"]
