Healthcheck
==

1.  Dokcerfile 里面本身要支持健康检查 , 例如:

```
HEALTHCHECK --interval=5m --timeout=3s \
  CMD curl -f http://localhost/ || exit 1
```


2.  docker-compose 文件里面使用该检查.

```
version: '2.1'
services:
  web:
    build: .
    depends_on:
      db:
        condition: service_healthy
      redis:
        condition: service_started
  redis:
    image: redis
  db:
    image: redis
    healthcheck:
      test: "exit 0"
	  
```


参考文献:
--

https://docs.docker.com/engine/reference/builder/#healthcheck


https://docs.docker.com/compose/compose-file/compose-file-v2/#compose-and-docker-compatibility-matrix