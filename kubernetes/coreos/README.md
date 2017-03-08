#### Install Kubernetes on CoreOS

### Install Prerequisites

## Vargant
Navigate to the [Vagrant downloads page](https://www.vagrantup.com/downloads.html)
and grab the appropriate package for your system.
Install the downloaded software before continuing.

## kubectl
`kubectl` is the main program for interacting with the Kubernetes API.
Download kubectl from the Kubernetes release artifact site with the curl tool.

The linux `kubectl` binary can be fetched with a command like:
`$ curl -O https://storage.googleapis.com/kubernetes-release/release/v1.5.2/bin/linux/amd64/kubectl`

On an OS X workstation, replace linux in the URL above with darwin:
`$ curl -O https://storage.googleapis.com/kubernetes-release/release/v1.5.2/bin/darwin/amd64/kubectl`

After downloading the binary, ensure it is executable and move it into your PATH:

``` bash
$ chmod +x kubectl
$ mv kubectl /usr/local/bin/kubectl
```

### Clone Repository

``` bash
$ git clone https://github.com/coreos/coreos-kubernetes.git
$ cd coreos-kubernetes/multi-node/vagrant
```

## Start the Machines
The default cluster configuration is to start a virtual machine for each role — master node,
worker node, and etcd server.
However, you can modify the default cluster settings by copying `config.rb.sample` to `config.rb`
and modifying configuration values.

```
#$update_channel="alpha"

#$controller_count=1
#$controller_vm_memory=1024

#$worker_count=1
#$worker_vm_memory=1024

#$etcd_count=1
#$etcd_vm_memory=512
```

Ensure the latest CoreOS vagrant image will be used by running `vagrant box update`.
Then run `vagrant up` and wait for Vagrant to provision and boot the virtual machines.

## Fucking issue

`sudo ln -sf /usr/local/bin/openssl /opt/vagrant/embedded/bin/openssl`
[one more](http://tech.yipp.ca/vagrant/fix-vagrant-machine-index-become-corrupt/)

### Configure kubectl

## Update the local-user kubeconfig

Configure your local Kubernetes client using the following commands:
``` bash
$ kubectl config set-cluster vagrant-multi-cluster --server=https://172.17.4.101:443 --certificate-authority=${PWD}/ssl/ca.pem
$ kubectl config set-credentials vagrant-multi-admin --certificate-authority=${PWD}/ssl/ca.pem --client-key=${PWD}/ssl/admin-key.pem --client-certificate=${PWD}/ssl/admin.pem
$ kubectl config set-context vagrant-multi --cluster=vagrant-multi-cluster --user=vagrant-multi-admin
$ kubectl config use-context vagrant-multi
```

Check that kubectl is configured properly by inspecting the cluster:
``` bash
$ kubectl get nodes
NAME          LABELS                               STATUS
172.17.4.201   kubernetes.io/hostname=172.17.4.201   Ready
```

### Install a sample application
``` bash
# kubectl create namespace sock-shop
# kubectl apply -n sock-shop -f "https://github.com/microservices-demo/microservices-demo/blob/master/deploy/kubernetes/complete-demo.yaml?raw=true"
```
