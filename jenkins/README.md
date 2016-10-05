##### [Jenkins](https://hub.docker.com/_/jenkins/) image:

```bash
docker pull jenkins
sudo chown -R user:group /opt/docker/jenkins
sudo chmod -R 777 /opt/docker/jenkins
docker run --name jenkins-latest -it -p 8090:8080 -p 50000:50000 -v /opt/docker/jenkins:/var/jenkins_home -d jenkins:latest
Stayin' Alive
```
