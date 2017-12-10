docker compose
==

官方文档
--

https://github.com/docker/compose/releases

Good Example Start with wordpress: https://docs.docker.com/compose/wordpress/#build-the-project


- Installation
--

下面语句的含义是: 到[Github](https://github.com/docker/compose/releases)上下载到正确的版本, 并且copy到指定的目录下面, 改成可执行属性就OK了. 十分简单.

```

curl -L "https://github.com/docker/compose/releases/download/1.9.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

chmod 770 /usr/local/bin/docker-compose
docker-compose version

```

or


```
curl -L https://github.com/docker/compose/releases/download/1.18.0-rc2/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

```

or

```
wget   https://github.com/docker/compose/releases/download/1.18.0-rc2/docker-compose-`uname -s`-`uname 
cp docker-compose-Linux-x86_64  /usr/local/bin/docker-compose
chmod 770 /usr/local/bin/docker-compose
docker-compose version

```

- Start Up With [docker-compose.yml](docker-compose.yml)
--

```

# 启动
docker-compose up -d 
# 停止
docker-compose stop
# 删除
docker-compose rm

```

启动后, 用 ``` docker-compose ps  ``` 看到已启动的容器.

```
       Name                      Command               State          Ports
-----------------------------------------------------------------------------------
compose_db_1          docker-entrypoint.sh mysqld      Up      3306/tcp
compose_wordpress_1   docker-entrypoint.sh apach ...   Up      0.0.0.0:8000->80/tcp

```

观察会发现:

- 容器的名字规律是 ``` 当前目录_服务名_序号 ```

- db 容器没有端口映射, 因为compose文件里面本来就把它定义为私有的. 而 wordpress 可以访问它, 是因为里面定义了 ``` depends_on: ```. 

- 用 docker inspect 指令观察 wordpress 容器, 可以发现下面的片段.

```
"Env": [
	"WORDPRESS_DB_HOST=db:3306",
	"WORDPRESS_DB_USER=wordpress",
	"WORDPRESS_DB_PASSWORD=wordpress",
```

观察可发现, 容器内部是用compose文件里面的服务名做host名的, 用上面这些信息足够拼凑出一个datasource url, 所以在配置数据源的时候, 不用写死ip, 是多么的方便.

- wordpress 的容器指定了端口映射, 所以可以从外部进行访问. 而且指定端口后, 重启服务, 端口也不会变化, 这样更加便于管控.

- Network 的类型,默认是 bridge 



