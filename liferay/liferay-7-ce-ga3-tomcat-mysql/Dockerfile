FROM liferay:7-ce-ga3-tomcat-hsql

MAINTAINER "Nikita Krivitski" <nikita.krivitski@azati.com>

ENV MYSQL_CONNECTOR_URL=https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.40.zip

RUN set -x \
    && curl -fSL "$MYSQL_CONNECTOR_URL" -o mysql-connector-java-5.1.40.zip \
    && unzip mysql-connector-java-5.1.40.zip \
    && rm mysql-connector-java-5.1.40.zip \
    && mv mysql-connector-java-5.1.40/mysql-connector-java-5.1.40-bin.jar mysql-connector-java-5.1.40/mysql.jar \
    && rm $LIFERAY_HOME/tomcat-8.0.32/lib/ext/mysql.jar \
    && cp mysql-connector-java-5.1.40/mysql.jar $LIFERAY_HOME/tomcat-8.0.32/lib/ext/ \
    && rm -r mysql-connector-java-5.1.40/

ADD ./configs/portal-ext.properties $LIFERAY_HOME/

ENTRYPOINT ["catalina.sh"]
CMD ["run"]
