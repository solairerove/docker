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
