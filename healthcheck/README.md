Healthcheck
==


方法一:
--

Dokcerfile 里面本身支持健康检查 , 例如:

```
HEALTHCHECK --interval=5m --timeout=3s \
  CMD curl -f http://localhost/ || exit 1
```


一个比较好的例子是mysql的[Dockerfile](https://github.com/qijunbo/mysql-docker/blob/mysql-server/5.7/Dockerfile)和[healthcheck.sh](https://github.com/qijunbo/mysql-docker/blob/mysql-server/5.7/healthcheck.sh) 的写法.


方法二: 
--

>(从docker-compose v2.1 开始支持, 但是 v3.4 才完全支持 HEALTHCHECK 的所有参数.)
 
docker-compose 文件里面使用该检查. 这里有一个运行成功的案例[docker-compose.yml](docker-compose.yml)

```
docker stack deploy -c docker-compose.yml swagger_demo

```
关于如何验证运行成功, 可以参考[service](../service/README.md)章节.


这种机制可以用来让容器web等待db启动成功,并完成初始化了之后再启动. 保证web可以成功启动.
有时候数据库初始化确实要很长时间.

```
version: "3.4"
services:
    web:
        build: .
        container_name: web
        ports:
            - "8080:8080"
    db:
        container_name: db
        image: mysql
        ports:
            - "3306"
        environment:
            MYSQL_ALLOW_EMPTY_PASSWORD: "yes"
            MYSQL_USER: "user"
            MYSQL_PASSWORD: "password"
            MYSQL_DATABASE: "database"
        healthcheck:
            test: ["CMD", "mysqladmin" ,"ping", "-h", "localhost"]
            interval: 30s
            timeout: 2s
            retries: 10
            start-period: 10m30s
	  
```


参考文献:
--

https://docs.docker.com/engine/reference/builder/#healthcheck


https://docs.docker.com/compose/compose-file/compose-file-v2/#compose-and-docker-compatibility-matrix


https://stackoverflow.com/questions/42567475/docker-compose-check-if-mysql-connection-is-ready