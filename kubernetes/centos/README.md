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
