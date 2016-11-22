#!/bin/bash

export JAVA_HOME=/opt/env/jdk1.8.0_92
export PATH=$JAVA_HOME/bin:$PATH

export M2_HOME=/opt/env/apache-maven-3.3.9
export PATH=$PATH:$M2_HOME/bin
export M2_OPTS="-Xmx512M -XX:MaxPermSize=256M"
export MAVEN_OPTS="-Xmx512M -XX:MaxPermSize=256M"

export GRADLE_HOME=/opt/env/gradle-3.0
export PATH=$GRADLE_HOME/bin:$PATH

export CATALINA_HOME=/opt/env/apache-tomcat-8.0.36
export PATH=$CATALINA_HOME/bin:$PATH
