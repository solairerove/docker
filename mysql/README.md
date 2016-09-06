##### [MySQL](https://hub.docker.com/_/mysql/) image for docker:

```docker pull mysql``` - download image
```docker run --name mysql-latest -v /my/own/datadir:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=mysqldb_pass -p 3306:3306 -d mysql:latest```
```docker exec -it mysql-latest bash``` - allows you to run commands inside a Docker container
```mysql -u root -p``` - to log in as the root user

___

##### Create new db and access user:

```mysql
create database database-name;
grant all on database-name.* to 'username' identified by 'user-password';
quit;
```

___

##### Summary:

So you pull image, run new container with your name, your root pass, your ports and db's files save in your host.