#!/bin/bash

systemctl stop firewalld
systemctl disable firewalld

yum -y install ntp
systemctl start ntpd
systemctl enable ntpd
