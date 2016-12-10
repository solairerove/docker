#!/bin/bash

yum install etcd flannel -y

cat > /etc/etcd/etcd.conf << '__EOF__'
# [member]
ETCD_NAME=default
ETCD_DATA_DIR="/var/lib/etcd/default.etcd"
ETCD_LISTEN_CLIENT_URLS="http://0.0.0.0:2379"
#[cluster]
ETCD_ADVERTISE_CLIENT_URLS="http://localhost:2379"
__EOF__

systemctl enable etcd
systemctl start etcd

sleep 5

echo '{"Network": "10.10.0.0/16", "SubnetLen": 24, "Backend": {"Type": "vxlan", "VNI": 1}}' | etcdctl set /atomic.io/network/config

etcdctl get /atomic.io/network/config

systemctl enable flanneld
systemctl start flanneld

# verify
curl -s http://kube-master:2379/v2/keys/atomic.io/network/subnets | python -m json.tool
curl -s http://kube-master:2379/v2/keys/atomic.io/network/config | python -m json.tool

systemctl start docker
