##### [MySQL](https://hub.docker.com/_/mysql/) image for docker:

```bash
docker pull mysql
docker run --name mysql-latest -v /opt/db/mysql-latest:/var/lib/mysql -e MYSQL_ROOT_PASSWORD="mysqldb_pass" -e MYSQL_DATABASE="lportal" -e MYSQL_USER="lportal_user" -e MYSQL_PASSWORD="lportal_pass" -p 3306:3306 -d mysql:latest
```

___

##### Summary:

So you pull image, run new container with your user, pass and db. Db's files save in host.
