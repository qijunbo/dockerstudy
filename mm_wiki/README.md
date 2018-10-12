docker_mm_wiki
==

https://github.com/qijunbo/docker_mm_wiki

这是一个失败的例子, 有借鉴意义
```
FROM alpine:3.8
MAINTAINER qijunbo <junboqi@foxmail.com> 
LABEL name="mm_wiki"
COPY  mm_wiki /
COPY  docker-entrypoint.sh /usr/local/bin/
ENV httpaddr=0.0.0.0 httpport=8080 db_host=127.0.0.1 db_port=8080 db_name=mm_wiki db_user=mm_wiki db_pass=mm_wiki db_conn_max_idle=30 db_conn_max_connection=200
VOLUME /md  /conf /logs
ENTRYPOINT docker-entrypoint.sh

```

ENV 的变量名是不可以带点 .  的, 例如 db.host 就是一个不合法的环境变量.