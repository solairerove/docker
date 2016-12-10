#!/bin/bash

yum install kubernetes-node -y

cat > /etc/kubernetes/node/kube-proxy.conf << '__EOF__'

KUBE_ETCD_SERVERS=""
KUBE_LOGTOSTDERR=""
KUBE_LOG_LEVEL=""

#Master api server http (--insecure-port) port=8080
#Master api server https (--secure-port) port=6443
KUBE_MASTER_SERVER="--master=http://kube-master:8080"

KUBE_PROXY_ARGS=""
__EOF__

cat > /etc/kubernetes/node/kubelet.conf << '__EOF__'

# The address for the info server to serve on (set to 0.0.0.0 or "" for all interfaces)
KUBELET_ADDRESS="--address=0.0.0.0"

# The port for the info server to serve on
KUBELET_PORT="--port=10250"

# You may leave this blank to use the actual hostname
KUBELET_HOSTNAME=""

# location of the api-server
KUBELET_API_SERVERS="--api_servers=http://kube-master:8080"

# Add your own!
KUBELET_ARGS="--container_runtime=docker --config=/etc/kubernetes/manifests"
__EOF__

for SERVICE in kube-proxy kubelet
do
    systemctl restart $SERVICE
    systemctl enable $SERVICE
done
