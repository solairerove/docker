##### Liferay 6.2-ce-ga6 image:

```bash
docker pull snasello/liferay-6.2:6.2-ce-ga6
docker run --name liferay-6.2 -it -p 8080:8080 -v /home/krivitski-no/soft/docker/liferay/deploy:/var/liferay-home/deploy -d snasello/liferay-6.2:6.2-ce-ga6
docker logs -f liferay-6.2
```
