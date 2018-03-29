
docker run --name h1 -it sequenceiq/hadoop-docker:2.7.1 /etc/bootstrap.sh -bash
docker run -td  -v /root/key1:/root/.ssh/ sequenceiq/hadoop-docker:2.7.1 /etc/bootstrap.sh -d

docker run --name ha  -td sequenceiq/hadoop-docker:2.7.1 /etc/bootstrap.sh -d


参考文献：
--

[hadoop 官方推荐docker镜像](https://hub.docker.com/r/sequenceiq/hadoop-docker/~/dockerfile/)

[hadoop 官方推荐docker镜像 使用指南](https://hub.docker.com/r/sequenceiq/hadoop-docker/)


docker容器和宿主之间的文件系统交互的小技巧
--

- 交互模式（-it）运行容器

```
docker run --name h1 -it sequenceiq/hadoop-docker:2.7.1 /etc/bootstrap.sh -bash
```

- 发现/root/.ssh/ 下面有预存的key



- detach模式（-td） 运行容器

```
docker run -td  --name ha sequenceiq/hadoop-docker:2.7.1 /etc/bootstrap.sh -d
```

- 用docker cp 命令把运行时容器里面的 /root/.ssh/ 内容copy出来。 

```
mkdir -p /root/key1
docker cp  ha:/root/.ssh/*   /root/key1
```

让容器启动时使用用户自己的证书
--

- 先用ssh-keygen 生成证书。

- 用 （-v） 指令让容器启动的时候mount外部文件系统。

```
mkdir -p /root/key1
##把证书copy到这个目录
docker run -td  -v /root/key1:/root/.ssh/ sequenceiq/hadoop-docker:2.7.1 /etc/bootstrap.sh -d

mkdir -p /root/key2
mkdir -p /root/key3

用不同的证书分别启动容器

```

进入一个正在运行的容器， 查看内部情况。
--

```
docker exec -it <容器id>  bash
```

