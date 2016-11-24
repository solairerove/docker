##### [PostgreSQL](https://hub.docker.com/_/postgres/) image for docker:

```bash
docker pull postgres:9.4
docker run --name postgres-latest -v /opt/db/postgres-latest:/var/lib/postgresql/data -e POSTGRES_USER=docker -e POSTGRES_PASSWORD=docker -e POSTGRES_DB=docker -p 5432:5432 -d postgres:9.4
```

```bash
docker pull postgres:9.4-alpine
docker run --name postgres-latest -v /opt/db/postgres-latest:/var/lib/postgresql/data -e POSTGRES_USER=docker -e POSTGRES_PASSWORD=docker -e POSTGRES_DB=docker -p 5432:5432 -d postgres:9.4-alpine
```
___

##### Summary:

So you pull image, run new container with your user, pass and db. Db's files save in host.
