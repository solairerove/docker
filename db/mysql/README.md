##### [MySQL](https://hub.docker.com/_/mysql/) image for docker:

```bash
docker pull mysql
docker run --name mysql-latest -v /opt/db/mysql-latest:/var/lib/mysql -e MYSQL_DATABASE=docker -e MYSQL_USER=docker -e MYSQL_PASSWORD=docker  -p 3306:3306 -d mysql:latest
```

___

##### Summary:

So you pull image, run new container with your user, pass and db. Db's files save in host.
