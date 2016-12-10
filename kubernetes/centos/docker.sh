#!/bin/bash

# add docker repo and install docker
cat > /etc/yum.repos.d/docker.repo << '__EOF__'
[docker]
name=Docker Repository
baseurl=https://yum.dockerproject.org/repo/main/centos/7
enabled=1
gpgcheck=1
gpgkey=https://yum.dockerproject.org/gpg
__EOF__

yum install docker-engine -y

mkdir -p /etc/systemd/system/docker.service.d

cat > /etc/systemd/system/docker.service.d/override.conf << '__EOF__'
[Service]
ExecStart=
ExecStart=/usr/bin/docker daemon --storage-driver=overlay $DOCKER_NETWORK_OPTIONS
__EOF__

systemctl daemon-reload
systemctl enable docker
