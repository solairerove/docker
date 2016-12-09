#!/bin/bash

apt-get install -y linux-libc-dev golang gcc
git clone https://github.com/coreos/flannel.git
cd flannel; make dist/flanneld-amd64
