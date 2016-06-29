#!/bin/bash

# install jdk-8u92

wget --no-check-certificate --no-cookies --header \
"Cookie: oraclelicense=accept-securebackup-cookie" \
http://download.oracle.com/otn-pub/java/jdk/8u92-b14/jdk-8u92-linux-x64.tar.gz

tar -xf jdk-8u92-linux-x64.tar.gz -C /usr/lib/jvm/
rm jdk-8u92-linux-x64.tar.gz

 install maven 3.3.9

wget http://apache.osuosl.org/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz

tar -xf apache-maven-3.3.9-bin.tar.gz -C /opt/
rm apache-maven-3.3.9-bin.tar.gz

# install tomcat 8.0.35

wget --quiet --no-cookies \ 
http://apache.rediris.es/tomcat/tomcat-8/v8.0.35/bin/apache-tomcat-8.0.35.tar.gz

tar -xf *.tar.gz -C /opt/
rm *.tar.gz
rm -rf /opt/tomcat/webapps/examples
rm -rf /opt/tomcat/webapps/docs

# export variables

rm -f variables.sh
touch variables.sh

echo export JAVA_HOME=/usr/lib/jvm/jdk1.8.0_92 >> variables.sh
#echo export PATH=$JAVA_HOME/bin:$PATH >> variables.sh

echo export PATH=/opt/apache-maven-3.3.9/bin:$PATH >> variables.sh

#echo export M2_HOME=/usr/local/apache-maven/apache-maven-3.3.9 >> variables.sh
#echo export M2=$M2_HOME/bin >> variables.sh
#echo export PATH=$M2:$PATH >> variables.sh

rm -f /etc/profile.d/variables.sh
cp variables.sh /etc/profile.d/


