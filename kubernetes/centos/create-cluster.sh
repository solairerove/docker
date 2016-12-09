#!/bin/bash

cat <<EOF > /etc/yum.repos.d/virt7-docker-common-release.repo
[virt7-docker-common-release]
name=virt7-docker-common-release
baseurl=http://cbs.centos.org/repos/virt7-docker-common-release/x86_64/os/
gpgcheck=0
EOF

yum -y install --enablerepo=virt7-docker-common-release kubernetes etcd flannel
