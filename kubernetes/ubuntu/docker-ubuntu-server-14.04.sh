#!/bin/bash

apt-get update
apt-get install -y apt-transport-https ca-certificates

apt-key adv \
  --keyserver hkp://ha.pool.sks-keyservers.net:80 \
  --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

echo "deb https://apt.dockerproject.org/repo ubuntu-trusty main" | tee /etc/apt/sources.list.d/docker.list
apt-get update

apt-get install -y linux-image-extra-$(uname -r) linux-image-extra-virtual

apt-get install -y docker-engine
service docker start
usermod -aG docker solairerove
systemctl enable docker

reboot
