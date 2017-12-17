Nginx
==

Setting Up a Http Proxy Server
--

-  get a web page 

```
mkdir -p /root/docker/web
cd /root/docker/web
wget https://www.baidu.com/
```

- start the nginx server

```
docker run --name nginx -v /root/docker/web:/usr/share/nginx/html:ro -d -p 8888:80 nginx
```

- Test

http://docker_host:8888


Setting Up a Simple Server
--

- you can either override the nginx.conf

```
docker run --name nginx -v /host/path/nginx.conf:/etc/nginx/nginx.conf:ro -d -p 8888:80 nginx
```

- or you can mount conf folder , and write you own conf file, then reload nginx

```
mkdir -p /host/path/conf.d
docker run --name nginx -v /host/path/conf.d:/etc/nginx/conf.d -d -p 8888:80 nginx
docker exec -it nginx nginx -s reload
```

Running nginx  with docker-compose
--

- downlad the [docker-compose.yml](docker-compose.yml)

```
docker-compose up -d
```

- Test

 http://docker-host:8888



Reference:
--
Docker Lib 文档

https://docs.docker.com/samples/library/nginx/#hosting-some-simple-static-content

Nginx 官方文档

https://nginx.org/en/docs/beginners_guide.html#proxy