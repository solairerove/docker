#!/bin/bash

export JAVA_HOME=/opt/jvm/jdk1.8.0_92
export PATH=$JAVA_HOME/bin:$PATH

export M2_HOME=/opt/apache-maven-3.3.9
export M2=$M2_HOME/bin
export PATH=$M2:$PATH
export MAVEN_OPTS="-Xms1024m -Xmx4096m -XX:PermSize=1024m"

export GRADLE_HOME=/opt/gradle-3.0
export PATH=$GRADLE_HOME/bin:$PATH

export CATALINA_HOME=/opt/apache-tomcat-8.0.36
export PATH=$CATALINA_HOME/bin:$PATH
