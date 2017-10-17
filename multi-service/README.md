Run multiple services in a container
==

Reference
--
https://docs.docker.com/engine/admin/multi-service_container/

Sample
--
- startall.sh
example 1:

```
while /bin/true; do
  sleep 60
done

```
example2: 

```
echo "Hello World!" > /hello.log
ping  -i 10 127.0.0.1
```

- Dockerfile

```
FROM tomcat:jre8-alpine
COPY startall.sh /usr/bin/startall
CMD ./startall
#CMD ["/usr/bin/startall"] 
```

- build.sh
```
chmod 711 *.sh
docker image build -t multi-services ./
```


