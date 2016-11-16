#!/bin/bash

export JAVA_HOME=/opt/env/jdk
export PATH=$JAVA_HOME/bin:$PATH

export M2_HOME=/opt/env/maven
export PATH=$PATH:$M2_HOME/bin
export M2_OPTS="-Xmx1024M -XX:MaxPermSize=256M"
export MAVEN_OPTS="-Xmx1024M -XX:MaxPermSize=256M"

export GRADLE_HOME=/opt/gradle-3.0
export PATH=$GRADLE_HOME/bin:$PATH

export CATALINA_HOME=/opt/apache-tomcat-8.0.36
export PATH=$CATALINA_HOME/bin:$PATH
