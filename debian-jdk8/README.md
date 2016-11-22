# debian-jdk8:

* `Base debian:jessie docker image with jdk8`

___

#### How start:

* `docker build -t debian:jdk8 .`
* `docker run --name debian-jdk8 -i -t -d debian:jdk8`

___

#### How start if you healthy user:

* `./debian_docker.sh build`
* `./debian_docker.sh run`

___

#### How push docker image to nexus3:

* Create or modify `/etc/docker/daemon.json`
```json
{ 
    "insecure-registries":["192.168.92.115:8083"] 
}
```
* `sudo service docker restart`
* `docker tag debian:jdk8 192.168.92.115:8083/debian:jdk8`
* `docker login 192.168.92.115:8083`
* `docker push 192.168.92.115:8083/debian:jdk8`
