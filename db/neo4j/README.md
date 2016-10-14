##### [Neo4j](https://hub.docker.com/_/neo4j/) image for docker:

```bash
docker pull neo4j:latest
docker run --name neo4j-latest -v /opt/docker/neo4j:/data -p 7474:7474 -p 7687:7687 -d neo4j:latest
```
___

##### Summary:

So you pull image, run new container with your user, pass and db. Db's files save in host.
