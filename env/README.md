ENV in Dockerfile
==

- [Dockerfile](Dockerfile)

在这个 Dockerfile 里面，我们定义了一个 USERNAME 环境变量， 默认值是 world。
这个镜像集成于nginx， 目的是想跑一个小的web服务器。

- [docker-entrypoint.sh](docker-entrypoint.sh)

这个是我们自定义的启动入口文件， 镜像启动时， 会执行这里面的语句。
我们在里面使用了之前定义的环境变量， 它被执行后，会在nginx默认的web目录里面生成一个index.html

页面的内容是 Hello，${USERNAME}.

- 执行[build.sh](build.sh)生成镜像。

- 测试 

打开[run.sh](run.sh)文件， 里面又两种执行方式。

不带 USERNAME 参数， 

```
docker run --name nginx -d -p 8888:80 envtest
```

在浏览器里面打开 http://docker-hosst:8888, 可以看见：

> Hello，world

用自定义的值取代默认的 USERNAME 值， 执行下面的语句

```
docker run --name nginx -e USERNAME=QIJUNBO -d -p 8888:80 envtest
```
执行后， 浏览器里面访问 http://docker-hosst:8888, 可以看见：

> Hello，QIJUNBO


