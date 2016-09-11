##### Tomcat8 image based on Alpine(135MB):

```bash
docker pull tomcat:8.0.37-jre8-alpine
docker run --name tomcat-8 -it -p 8989:8080 -d tomcat:8.0.37-jre8-alpine
```

___

##### Tomcat8 latest(357MB):

```bash
docker pull tomcat
docker run --name tomcat-latest -it -p 8991:8080 -v /my/own/datadir:/usr/local/tomcat/webapps -d tomcat:latest
```
