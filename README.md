#### Docker images for ordinary use

##### Cookies:

```bash
docker attach [CONTAINER_ID]
docker exec -u root -it [CONTAINER_ID] bash
export TERM=xterm (nano)
docker exec -it [CONTAINER_ID] /bin/bash -c "export TERM=xterm; exec bash"
docker exec -it [CONTAINER_ID] /bin/bash
docker exec -ti [CONTAINER_ID] ping [CONTAINER_ID] 
docker start [CONTAINER_ID]
docker stop [CONTAINER_ID]
docker rm [CONTAINER_ID] [CONTAINER_ID] ...
docker rmi -f [IMAGE_ID]
docker ps
docker ps -a
```

___ 
