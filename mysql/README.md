##### [MySQL](https://hub.docker.com/_/mysql/) image for docker:

```shell
docker pull mysql
docker run --name mysql-latest -v /my/own/datadir:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=mysqldb_pass -p 3306:3306 -d mysql:latest
docker exec -it mysql-latest bash
mysql -u root -p
```
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