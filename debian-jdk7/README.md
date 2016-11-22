# debian-jdk7:

* `Base debian:jessie docker image with jdk7`

___

#### How start:

* `docker build -t debian:jdk7 .`
* `docker run --name debian-jdk7 -i -t -d debian:jdk7`

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
* `docker tag debian:jdk7 192.168.92.115:8083/debian:jdk7`
* `docker login 192.168.92.115:8083`
* `docker push 192.168.92.115:8083/debian:jdk7`
