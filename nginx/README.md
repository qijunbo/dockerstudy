Nginx
==

Setting Up a Http Proxy Server
--

-  get a web page 

```
wget https://www.baidu.com/
```

- start the nginx server

```
docker run --name nginx -v $(pwd):/usr/share/nginx/html:ro -d -p 8888:80 nginx
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

Note:
> there is a [default.conf](conf.d/default.conf),  this file is the nginx default sample configure file which will make the container work properly. which is a wonderful sample to refer to .

- downlad the [docker-compose.yml](docker-compose.yml)

```
docker-compose up -d
```

- Test

 http://docker-host:8888


- Link other existing container in nginx

https://docs.docker.com/registry/recipes/nginx/#starting-and-stopping
 
下面这个是不使用 service 模式的用法, 用links属性来访问已经启动的容器, 其实不算太屌.   一旦遇上集群模式, links属性就被忽略了.
```
nginx:
  # Note : Only nginx:alpine supports bcrypt.
  # If you don't need to use bcrypt, you can use a different tag.
  # Ref. https://github.com/nginxinc/docker-nginx/issues/29
  image: "nginx:alpine"
  ports:
    - 5043:443
  links:
    - registry:registry
  volumes:
    - ./auth:/etc/nginx/conf.d
    - ./auth/nginx.conf:/etc/nginx/nginx.conf:ro

registry:
  image: registry:2
  ports:
    - 127.0.0.1:5000:5000
  volumes:
    - ./data:/var/lib/registry
```

比较屌的解决思路还是下面:  用bridge模式的network, 把需要代理的端口暴露出来.  nginx 是不能加到一个内部网络的, 至少目前是这样. 这样nginx即使不在自定义的网络内部, 也照样可以访问自定义网络的服务.

```json
version: '3.4'
networks:
  webnet:
    driver: bridge
services:
  mysqldb:
    image: mysql:5.7
    container_name: mysqldb
    ports:
      - "3307:3306"
    volumes:
      - /opt/limsst/mysql/data:/var/lib/mysql
      - ./config/mysql/initsql/:/docker-entrypoint-initdb.d
      - ./config/mysql/docker.cnf:/etc/my.cnf
    networks:
      - webnet   
    restart: always
    environment:
      MYSQL_ROOT_PASSWORD: sunway123#
  estandard:
    depends_on:
      - mysqldb
      - redis
      - eureka
    image: registry.cn-hangzhou.aliyuncs.com/qijunbo/estandard:1
    volumes:
      - ./logs/estandard:/app-log
      - ./config/estandard:/config
    deploy:
      replicas: 1
#      resources:
#        limits:
#          cpus: "0.5"
#          memory: 2048M
      restart_policy:
        condition: on-failure
    ports:
      - "8102:8102"
    networks:
      - webnet
    restart: always
  portal:
    depends_on:
      - mysqldb 
      - redis
      - eureka
    image: registry.cn-hangzhou.aliyuncs.com/qijunbo/portal:1
    volumes:
      - ./logs/portal:/app-log
      - ./config/portal:/config
    deploy:
      replicas: 1
      resources:
        limits:
          cpus: "0.3"
          memory: 1024M
      restart_policy:
        condition: on-failure
    ports:
      - "8103:8103"
    networks:
      - webnet
    restart: always
  msggateway:
    depends_on:
      - mysqldb 
      - redis
      - eureka
    image: registry.cn-hangzhou.aliyuncs.com/qijunbo/msggateway:1
    volumes:
      - ./logs/msggateway:/app-log
    deploy:
      replicas: 1
      resources:
        limits:
          cpus: "0.1"
          memory: 512M
      restart_policy:
        condition: on-failure
    ports:
      - "8002:8002"
    networks:
      - webnet
    restart: always
  central:
    depends_on:
      - mysqldb 
      - redis
      - eureka
    image: registry.cn-hangzhou.aliyuncs.com/qijunbo/central:1
    volumes:
      - ./logs/central:/app-log
      - ./config/central:/config
    deploy:
      replicas: 1
      resources:
        limits:
          cpus: "0.3"
#          memory: 1024M
      restart_policy:
        condition: on-failure
    ports:
      - "8006:8006"
    networks:
      - webnet
    restart: always
  redis:
      image: redis:alpine
      ports:
        - "6379:6379"
      networks:
        - webnet
      deploy:
        restart_policy:
          condition: on-failure
  eureka:
#      image: springcloud/eureka
      image: registry.cn-hangzhou.aliyuncs.com/qijunbo/eureka
      ports:
        - "8761:8761"
      networks:
        - webnet
      deploy:
        restart_policy:
          condition: on-failure
  nginx:
    # Note : Only nginx:alpine supports bcrypt.
    # If you don't need to use bcrypt, you can use a different tag.
    # Ref. https://github.com/nginxinc/docker-nginx/issues/29
    image: "nginx:alpine"
    ports:
      - 8090:80
    volumes:
      - ./config/nginx/:/etc/nginx/conf.d/
    restart: always
  solr:
    image: solr:7.2.1
    volumes:
      - ./config/solr/jar/mysql-connector-java-5.1.6.jar:/opt/solr/server/solr-webapp/webapp/WEB-INF/lib/mysql-connector-java-5.1.6.jar
      - ./config/solr/estandard/:/opt/solr/server/solr/estandard/
    deploy:
      replicas: 1
      restart_policy:
        condition: on-failure
    ports:
     - "8983:8983"
    entrypoint:
      - docker-entrypoint.sh
      - solr-create
      - "-c"
      - estandard
    networks:
      - webnet


```

Reference:
--
Docker Lib 文档

https://docs.docker.com/samples/library/nginx/#hosting-some-simple-static-content

Nginx 官方文档

https://nginx.org/en/docs/beginners_guide.html#proxy