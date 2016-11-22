FROM debian:jessie

MAINTAINER "Nikita Krivitski" <hax2033@gmail.com>

ENV LOCALES_DEF en_US.UTF-8
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update &&  \
    apt-get upgrade -y &&  \
    DEBIAN_FRONTEND=noninteractive  \
    apt-get -o Dpkg::Options::='--force-confnew' install -y \
        locales \
        curl \
        unzip

RUN set -- junk $LOCALES_DEF  \
    shift;  \
    for THE_LOCALE in $LOCALES_DEF; do  \
        set --  $(echo $THE_LOCALE  |  awk -F'.' '{ print $1, $2 }');  \
        INPUT_FILE=$1;  \
        CHARMAP_FILE=$2;  \
        localedef  --no-archive -c -i $INPUT_FILE -f $CHARMAP_FILE $THE_LOCALE;  \
    done ; \
    locale-gen

RUN echo "generated locales are:" && locale -a

ENV JAVA_HOME /opt/jdk1.8.0_111

RUN curl -jksSLH "Cookie: oraclelicense=accept-securebackup-cookie" \
    http://download.oracle.com/otn-pub/java/jdk/8u111-b14/jdk-8u111-linux-x64.tar.gz \
    | tar -xzf - -C /opt && \
    mkdir /opt/env && \
    ln -s $JAVA_HOME /opt/env/jdk && \
    rm -rf /opt/env/jdk/*src.zip \
           /opt/env/jdk/lib/missioncontrol \
           /opt/env/jdk/lib/visualvm \
           /opt/env/jdk/lib/*javafx* \
           /opt/env/jdk/jre/lib/plugin.jar \
           /opt/env/jdk/jre/lib/ext/jfxrt.jar \
           /opt/env/jdk/jre/bin/javaws \
           /opt/env/jdk/jre/lib/javaws.jar \
           /opt/env/jdk/jre/lib/desktop \
           /opt/env/jdk/jre/plugin \
           /opt/env/jdk/jre/lib/deploy* \
           /opt/env/jdk/jre/lib/*javafx* \
           /opt/env/jdk/jre/lib/*jfx* \
           /opt/env/jdk/jre/lib/amd64/libdecora_sse.so \
           /opt/env/jdk/jre/lib/amd64/libprism_*.so \
           /opt/env/jdk/jre/lib/amd64/libfxplugins.so \
           /opt/env/jdk/jre/lib/amd64/libglass.so \
           /opt/env/jdk/jre/lib/amd64/libgstreamer-lite.so \
           /opt/env/jdk/jre/lib/amd64/libjavafx*.so \
           /opt/env/jdk/jre/lib/amd64/libjfx*.so \
    && rm -rf /tmp/* \
    && rm -rf /var/cache/apk/* \
    && echo 'hosts: files mdns4_minimal [NOTFOUND=return] dns mdns4' >> /etc/nsswitch.conf

ENV PATH ${PATH}:${JAVA_HOME}/bin

RUN apt-get clean  &&  \
    rm -rf /var/lib/apt/lists/*

CMD ["/bin/bash"]
