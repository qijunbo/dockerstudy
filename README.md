# dockerstudy
all kinds of docker  images design

# 学习计划

- [怎样在Dockerfile里使用环境变量](env/README.md) [完成]


# Index of Content

- [installation guid](install.md)
- [installation docker-compose](docker-compose/README.md)
- [Start a mysql db](mysql/README.md)
- [Start a webapp use the db](java8/README.md)
- [multi-service](multi-service/README.md)
- [常用指令](command.md)
- [REST API](rest/README.md)
- [Restart](restart/readme.md)
- [registry](registry/README.md)
- [希云教程](http://csphere.cn/training)
- [git学习笔记](git.md)


# Question 1

Why some exit while others keep running when you run containers using follwing command.

```
docker run -d  container_name 
```
那是因为

```
CMD ["commands", "parm"]
```

有的执行完了就退出了, 有的长期运行,永不停歇.


 

知识扩展：
--

[搭建Git服务器](https://git-scm.com/book/zh/v2/%E6%9C%8D%E5%8A%A1%E5%99%A8%E4%B8%8A%E7%9A%84-Git-%E5%9C%A8%E6%9C%8D%E5%8A%A1%E5%99%A8%E4%B8%8A%E6%90%AD%E5%BB%BA-Git)

