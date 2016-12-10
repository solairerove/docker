#!/bin/bash

# verify
curl -s http://kube-master:2379/v2/keys/atomic.io/network/subnets | python -m json.tool
curl -s http://kube-master:2379/v2/keys/atomic.io/network/config | python -m json.tool

yum install flannel -y

cat > /etc/sysconfig/flanneld << '__EOF__'
FLANNEL_ETCD="http://kube-master:2379"
FLANNEL_ETCD_KEY="/atomic.io/network"
__EOF__

systemctl enable flanneld
systemctl start flanneld

systemctl start docker
