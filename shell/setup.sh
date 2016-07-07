#!/bin/bash

RED='\033[0;31m'
NC='\033[0m'

printf "${RED} <== install jdk-8u92 ==> ${NC} \n"

wget --no-check-certificate --no-cookies --header \
"Cookie: oraclelicense=accept-securebackup-cookie" \
http://download.oracle.com/otn-pub/java/jdk/8u92-b14/jdk-8u92-linux-x64.tar.gz

tar -xf jdk-8u92-linux-x64.tar.gz -C /usr/lib/jvm/
rm jdk-8u92-linux-x64.tar.gz

update-alternatives --remove-all javac
update-alternatives --remove-all java
update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/jdk1.8.0_92/bin/javac 1
update-alternatives --install /usr/bin/java java /usr/lib/jvm/jdk1.8.0_92/bin/java 1
update-alternatives --config javac
update-alternatives --config java

printf "${RED} <== install maven 3.3.9 ==> ${NC} \n"

wget http://apache.osuosl.org/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz

tar -xf apache-maven-3.3.9-bin.tar.gz -C /opt/
rm apache-maven-3.3.9-bin.tar.gz

printf "${RED} <== install tomcat 8.0.36 ==> ${NC} \n"

wget --quiet --no-cookies \
http://www-us.apache.org/dist/tomcat/tomcat-8/v8.0.36/bin/apache-tomcat-8.0.36.tar.gz

tar -xf apache-tomcat-8.0.36.tar.gz -C /opt/
rm apache-tomcat-8.0.36.tar.gz
rm -rf /opt/apache-tomcat-8.0.36/webapps/examples
rm -rf /opt/apache-tomcat-8.0.36/webapps/docs

chown -R $(whoami) /opt/apache-tomcat-8.0.36/
chmod -R 777 /opt/apache-tomcat-8.0.36/

printf "${RED} <== install docker ==> ${NC} \n"

wget -qO- https://get.docker.com/ | sh

printf "${RED} <== install docker-compose ==> ${NC} \n"

curl -L https://github.com/docker/compose/releases/download/1.7.1/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

printf "${RED} <== install git ==> ${NC} \n"

GIT_NAME="Nikita Krivitski"
GIT_EMAIL="hax2033@gmail.com"

apt-get install -y git

git config --global user.name "$GIT_NAME"
git config --global user.email $GIT_EMAIL

printf "${RED} <== install skype ==> ${NC} \n"

apt-get install -y skype

printf "${RED} <== install chrome ==> ${NC} \n"

wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
dpkg -i google-chrome-stable_current_amd64.deb
apt-get -f install -y
rm -f google-chrome-stable_current_amd64.deb

printf "${RED} <== install virtual box ==> ${NC} \n"

wget http://download.virtualbox.org/virtualbox/5.0.24/virtualbox-5.0_5.0.24-108355~Ubuntu~xenial_amd64.deb
dpkg -i virtualbox-5.0_5.0.24-108355~Ubuntu~xenial_amd64.deb
rm -f virtualbox-5.0_5.0.24-108355~Ubuntu~xenial_amd64.deb

printf "${RED} <== install node and npm ==> ${NC} \n"

apt-get install -y build-essential libssl-dev
apt-get install -y nodejs
ln -s /usr/bin/nodejs /usr/bin/node
apt-get install -y npm

printf "${RED} <== install gulp ==> ${NC} \n"

npm install -g gulp

printf "${RED} <== install typescript ==> ${NC} \n"

npm install -g typescript

printf "${RED} <== install Intellij IDEA ==> ${NC} \n"

wget https://download.jetbrains.com/idea/ideaIU-2016.1.3.tar.gz

mkdir ~/soft
tar -xf ideaIU-2016.1.3.tar.gz -C ~/soft/
rm ideaIU-2016.1.3.tar.gz

chmod +x ~/soft/idea-IU-145.1617.8/bin/idea.sh
sed -i '2s/.*/-Xmx2048m/' ~/soft/idea-IU-145.1617.8/bin/idea64.vmoptions

printf "${RED} <== install audacious ==> ${NC} \n"

apt-get install -y audacious

printf "${RED} <== install gitkraken ==> ${NC} \n"

wget https://release.gitkraken.com/linux/gitkraken-amd64.deb
dpkg -i gitkraken-amd64.deb
rm -f gitkraken-amd64.deb

printf "${RED} <== install apache jmeter ==> ${NC} \n"

wget http://ftp.byfly.by/pub/apache.org//jmeter/binaries/apache-jmeter-3.0.tgz
tar -xf apache-jmeter-3.0.tgz -C ~/soft/
rm apache-jmeter-3.0.tgz

chmod +x ~/soft/apache-jmeter-3.0/bin/jmeter.sh

printf "${RED} <== install apache directory studio ==> ${NC} \n"

APACHE_STUDIO=ApacheDirectoryStudio-2.0.0.v20151221-M10-linux.gtk.x86_64.tar.gz

wget http://ftp.byfly.by/pub/apache.org/directory/studio/2.0.0.v20151221-M10/$APACHE_STUDIO
tar -xf $APACHE_STUDIO -C ~/soft/
rm $APACHE_STUDIO

printf "${RED} <== install mc  ==> ${NC} \n"

apt-get install -y mc

printf "${RED} <== install guake ==> ${NC} \n"

apt-get install -y guake

printf "${RED} <== export variables  ==> ${NC} \n"

rm -f variables.sh
touch variables.sh

echo export JAVA_HOME=/usr/lib/jvm/jdk1.8.0_92 >> variables.sh
echo export JMETER_HOME=~/soft/apache-jmeter-3.0 >> variables.sh

echo export PATH=/opt/apache-maven-3.3.9/bin:$PATH >> variables.sh
echo export PATH=~/soft/apache-jmeter-3.0/bin:$PATH >> variables.sh

rm -f /etc/profile.d/variables.sh
cp variables.sh /etc/profile.d/
rm -f variables.sh
