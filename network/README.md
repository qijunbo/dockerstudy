
how to network your containers
--

- Create a network

```
docker network create -d bridge lims_network
docker network ls
```

- Add containers to a network

```
docker network connect lims_network web
 #or
docker run -d --net=lims_network --name db training/postgres

docker inspect --format='{{json .NetworkSettings.Networks}}'  db
```

- Disconnect containers from a network

```
docker network disconnect lims_network my_container
docker network inspect lims_network
```

- Test

Open a shell into the db application again and try the ping command. This time just use the container name ** web ** rather than the IP address.

```
docker exec -it db bash
ping  web

#or

docker exec -it db ping  web
```