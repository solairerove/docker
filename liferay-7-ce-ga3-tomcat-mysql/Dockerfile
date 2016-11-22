FROM liferay:7-ce-ga3-tomcat-hsql

MAINTAINER "Nikita Krivitski" <hax2033@gmail.com>

ADD ./configs/portal-ext.properties $LIFERAY_HOME/

ENTRYPOINT ["catalina.sh"]
CMD ["run"]
