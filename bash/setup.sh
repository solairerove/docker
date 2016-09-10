#!/bin/bash

RED='\033[0;31m'
NC='\033[0m'

printf "${RED} <== install jdk-8u92 ==> ${NC} \n"

wget --no-check-certificate --no-cookies --header \
"Cookie: oraclelicense=accept-securebackup-cookie" \
http://download.oracle.com/otn-pub/java/jdk/8u92-b14/jdk-8u92-linux-x64.tar.gz

mkdir -p /opt/jvm
tar -xf jdk-8u92-linux-x64.tar.gz -C /opt/jvm

update-alternatives --remove-all javac
update-alternatives --remove-all java
update-alternatives --install /usr/bin/javac javac /opt/jvm/jdk1.8.0_92/bin/javac 1
update-alternatives --install /usr/bin/java java /opt/jvm/jdk1.8.0_92/bin/java 1
update-alternatives --config javac
update-alternatives --config java

printf "${RED} <== install maven 3.3.9 ==> ${NC} \n"

wget http://apache.osuosl.org/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz

tar -xf apache-maven-3.3.9-bin.tar.gz -C /opt/

printf "${RED} <== install tomcat 8.0.37 ==> ${NC} \n"

wget --quiet --no-cookies \
http://ftp.byfly.by/pub/apache.org/tomcat/tomcat-8/v8.0.37/bin/apache-tomcat-8.0.37.tar.gz

printf "${RED} <== extract compressed tar file ==> ${NC} \n"

tar -xf apache-tomcat-8.0.37.tar.gz -C /opt/
rm -rf /opt/apache-tomcat-8.0.37/webapps/examples
rm -rf /opt/apache-tomcat-8.0.37/webapps/docs

chown -R $(whoami) /opt/apache-tomcat-8.0.37/
chmod -R 777 /opt/apache-tomcat-8.0.37/

printf "${RED} <== install Intellij IDEA ==> ${NC} \n"

wget https://download.jetbrains.com/idea/ideaIU-2016.2.3.tar.gz

mkdir -p /opt/soft/
tar -xf ideaIU-2016.2.3.tar.gz -C /opt/soft/

printf "${RED} <== export variables  ==> ${NC} \n"

rm -f /etc/profile.d/variables.sh
cp variables.sh /etc/profile.d/
