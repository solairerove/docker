## Kubernetes install on Centos 7

### All nodes

###### Log as root:
`sudo su -`

###### Update os and install some apps:
``` bash
yum update
yum install nano mc htop
```

###### Change hostname:
``` bash
# /etc/hostname
echo myserver.domain.com > /etc/hostname

# /etc/sysconfig/network
echo HOSTNAME=myserver.domain.com > /etc/sysconfig/network

# /etc/hosts
tee -a /etc/hosts << '__EOF__'

192.168.93.212 kube-master
192.168.93.203 kube-node1
__EOF__

/etc/init.d/network restart
```

###### Disable firewalld:
``` bash
systemctl disable firewalld
systemctl stop firewalld
```

###### Install NTP:
``` bash
yum -y install ntp
systemctl start ntpd
systemctl enable ntpd
```

###### Docker install:
``` bash
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

```

### Prepare master:
``` bash 
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
```
### Prepare node:
``` bash
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
```
### Kube setup:
``` bash
yum install kubernetes-master -y

for SERVICE in kube-apiserver kube-scheduler kube-controller-manager
do
    systemctl restart $SERVICE
    systemctl enable $SERVICE
    systemctl status $SERVICE
done
```
### Node setup:
``` bash
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
```
