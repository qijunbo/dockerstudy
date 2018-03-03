Healthcheck
==

1.  Dokcerfile 里面本身要支持健康检查 , 例如:

```
HEALTHCHECK --interval=5m --timeout=3s \
  CMD curl -f http://localhost/ || exit 1
```


2.  docker-compose 文件里面使用该检查.

```
version: "2.1"
services:
    api:
        build: .
        container_name: api
        ports:
            - "8080:8080"
        depends_on:
            db:
                condition: service_healthy
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
			start-period: 300s
	  
```


参考文献:
--

https://docs.docker.com/engine/reference/builder/#healthcheck


https://docs.docker.com/compose/compose-file/compose-file-v2/#compose-and-docker-compatibility-matrix


https://stackoverflow.com/questions/42567475/docker-compose-check-if-mysql-connection-is-ready