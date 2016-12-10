## Kubernetes install on Centos 7

### All machines

##### Log as root:
`sudo su -`

##### Update os and install some apps:
```bash
yum update
yum install nano mc htop
```

##### Change hostname:
```
# /etc/hostname
myserver.domain.com

# /etc/sysconfig/network
HOSTNAME=myserver.domain.com

# /etc/hosts
replace-with-master-server-ip kube-master
replace-with-node1-ip kube-node1

/etc/init.d/network restart
```
