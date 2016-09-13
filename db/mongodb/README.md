##### [MongoDB](https://hub.docker.com/_/mongo/) image for docker:

```bash
docker pull mongo
docker run --name mongo-latest -v /opt/db/mongo:/data/db -e MONGODB_USER="docker" -e MONGODB_PASS="docker" -e MONGODB_DATABASE="docker" -p 27017:27017 -d mongo:latest
```
___

##### Summary:

So you pull image, run new container with your user, pass and db. Db's files save in host.
