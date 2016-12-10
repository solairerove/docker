#!/bin/bash

yum install kubernetes-master -y

for SERVICE in kube-apiserver kube-scheduler kube-controller-manager
do
    systemctl restart $SERVICE
    systemctl enable $SERVICE
    systemctl status $SERVICE
done
