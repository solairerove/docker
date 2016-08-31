#!/bin/bash

RED='\033[0;31m'
NC='\033[0m'

printf "${RED} <== install jdk-8u101 ==> ${NC} \n"

wget --no-check-certificate --no-cookies --header \
"Cookie: oraclelicense=accept-securebackup-cookie" \
http://download.oracle.com/otn-pub/java/jdk/8u101-b13/jdk-8u101-linux-x64.tar.gz

mkdir /usr/lib/jvm/
tar -xf jdk-8u101-linux-x64.tar.gz -C /usr/lib/jvm/

printf "${RED} <== install maven 3.3.9 ==> ${NC} \n"

wget http://apache.osuosl.org/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz

tar -xf apache-maven-3.3.9-bin.tar.gz -C /opt/

printf "${RED} <== install tomcat 8.0.36 ==> ${NC} \n"

wget --quiet --no-cookies \
http://www-us.apache.org/dist/tomcat/tomcat-8/v8.0.36/bin/apache-tomcat-8.0.36.tar.gz

tar -xf apache-tomcat-8.0.36.tar.gz -C /opt/
rm -rf /opt/apache-tomcat-8.0.36/webapps/examples
rm -rf /opt/apache-tomcat-8.0.36/webapps/docs

chown -R $(whoami) /opt/apache-tomcat-8.0.36/
chmod -R 777 /opt/apache-tomcat-8.0.36/

printf "${RED} <== install Intellij IDEA ==> ${NC} \n"

wget https://download.jetbrains.com/idea/ideaIU-2016.2.3.tar.gz

tar -xf ideaIU-2016.2.3.tar.gz -C ~/soft/
#rm ideaIU-2016.1.3.tar.gz

#chmod +x ~/soft/idea-IU-145.1617.8/bin/idea.sh
#sed -i '2s/.*/-Xmx2048m/' ~/soft/idea-IU-145.1617.8/bin/idea64.vmoptions

printf "${RED} <== export variables  ==> ${NC} \n"

rm -f /etc/profile.d/variables.sh
cp variables.sh /etc/profile.d/
#rm -f variables.sh
