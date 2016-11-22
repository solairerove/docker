# liferay-7-ce-ga3-tomcat-hsql:

* `Base liferay-7-ce-ga3-tomcat-hsql docker image with embedded database`

___

#### How start:

* `docker build -t liferay:7-ce-ga3-tomcat-hsql .`
* `docker run --name liferay-7-ce-ga3-tomcat-hsql -i -t -d liferay:7-ce-ga3-tomcat-hsql`

___

#### How start if you healthy user:

* `./lportal_docker.sh build`
* `./lportal_docker.sh run`

___

#### How push docker image to nexus3:

* Create or modify `/etc/docker/daemon.json`
```json
{ 
    "insecure-registries":["192.168.92.115:8083"] 
}
```
* `sudo service docker restart`
* `docker tag liferay:7-ce-ga3-tomcat-hsql 192.168.92.115:8083/liferay:7-ce-ga3-tomcat-hsql`
* `docker login 192.168.92.115:8083`
* `docker push 192.168.92.115:8083/liferay:7-ce-ga3-tomcat-hsql`
