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

### Restore and backup

To import dump `gunzip -c [PATH_TO_GZ] | docker exec -i [CONTAINER_NAME] psql -h [HOST] -U [USER] -W -d [DB_NAME]`

To backup `docker exec -t your-db-container pg_dumpall -c -U postgres > dump_`date +%d-%m-%Y"_"%H_%M_%S`.sql`

Form Serhio Baranov `/usr/bin/pg_dump -Fp -h localhost -p 5432 -U postgres cca | gzip > /home/cca"_"$(date +%Y%m%d_%H%M%S).gz`

##### Summary:

So you pull image, run new container with your user, pass and db. Db's files save in host.
