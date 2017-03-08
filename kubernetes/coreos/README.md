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
