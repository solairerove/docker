#!/bin/bash

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
