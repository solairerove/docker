#!/bin/bash

RED='\033[0;31m'
NC='\033[0m'

printf "${RED} <== install jdk-8u92 ==> ${NC} \n"

wget --no-check-certificate --no-cookies --header \
"Cookie: oraclelicense=accept-securebackup-cookie" \
http://download.oracle.com/otn-pub/java/jdk/8u92-b14/jdk-8u92-linux-x64.tar.gz

mkdir -p /usr/lib/jvm
tar -xf jdk-8u92-linux-x64.tar.gz -C /usr/lib/jvm/

update-alternatives --remove-all javac
update-alternatives --remove-all java
update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/jdk1.8.0_92/bin/javac 1
update-alternatives --install /usr/bin/java java /usr/lib/jvm/jdk1.8.0_92/bin/java 1
update-alternatives --config javac
update-alternatives --config java

printf "${RED} <== install maven 3.3.9 ==> ${NC} \n"

wget http://apache.osuosl.org/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz

tar -xf apache-maven-3.3.9-bin.tar.gz -C /opt/

printf "${RED} <== install tomcat 8.0.36 ==> ${NC} \n"

wget --quiet --no-cookies \
http://www-us.apache.org/dist/tomcat/tomcat-8/v8.0.36/bin/apache-tomcat-8.0.36.tar.gz

tar -xf apache-tomcat-8.0.36.tar.gz -C /opt/
rm -rf /opt/apache-tomcat-8.0.36/webapps/examples
rm -rf /opt/apache-tomcat-8.0.36/webapps/docs

# TODO $(whoami) after sudo is root
chown -R $(whoami) /opt/apache-tomcat-8.0.36/
chmod -R 777 /opt/apache-tomcat-8.0.36/

printf "${RED} <== install Intellij IDEA ==> ${NC} \n"

wget https://download.jetbrains.com/idea/ideaIU-2016.2.3.tar.gz

# TODO fix ~/ directory as root home
mkdir -p ~/soft/
tar -xf ideaIU-2016.2.3.tar.gz -C ~/soft/

chmod +x ~/soft/idea-IU-162.1817.17/bin/idea.sh
#sed -i '2s/.*/-Xmx1280m/' ~/soft/idea-IU-162.1817.17/bin/idea64.vmoptions

printf "${RED} <== export variables  ==> ${NC} \n"

rm -f /etc/profile.d/variables.sh
cp variables.sh /etc/profile.d/

# TODO What the fuck is this?
#printf "${RED} <== install docker-compose ==> ${NC} \n"

#curl -L https://github.com/docker/compose/releases/download/1.7.1/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
#chmod +x /usr/local/bin/docker-compose

#printf "${RED} <== install docker ==> ${NC} \n"

#wget -qO- https://get.docker.com/ | sh
