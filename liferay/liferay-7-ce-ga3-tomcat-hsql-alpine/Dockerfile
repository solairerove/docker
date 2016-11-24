FROM alpine:jdk8

MAINTAINER "Nikita Krivitski" <hax2033@gmail.com>

ENV LIFERAY_HOME=/usr/local/liferay-ce-portal-7.0-ga3

RUN mkdir -p "$LIFERAY_HOME"

ENV CATALINA_HOME=$LIFERAY_HOME/tomcat-8.0.32

ENV PATH=$CATALINA_HOME/bin:$PATH

ENV LIFERAY_TOMCAT_URL=https://sourceforge.net/projects/lportal/files/Liferay%20Portal/7.0.2%20GA3/liferay-ce-portal-tomcat-7.0-ga3-20160804222206210.zip/download

WORKDIR /usr/local
RUN apk add --no-cache --virtual=build-dependencies curl unzip && \
    set -x \
	&& curl -fSL "$LIFERAY_TOMCAT_URL" -o liferay-ce-portal-tomcat-7.0-ga3-20160804222206210.zip \
	&& unzip liferay-ce-portal-tomcat-7.0-ga3-20160804222206210.zip \
	&& rm liferay-ce-portal-tomcat-7.0-ga3-20160804222206210.zip \
	&& apk del build-dependencies

ADD ./config/setenv.sh $LIFERAY_HOME/tomcat-8.0.32/bin/setenv.sh

EXPOSE 8080

VOLUME ["/usr/local/liferay-ce-portal-7.0-ga3/deploy"]

ENTRYPOINT ["catalina.sh"]
CMD ["run"]
