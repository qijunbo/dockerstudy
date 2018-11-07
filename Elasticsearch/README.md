![elastic](document/image/elastic.svg) 日志管理
==


日志管理用于记录日志, 并提供全文检索. 本方案采用Elasticsearch全文搜索引擎.

本服务提供两个接口, 一个是追加记录, 一个是搜索.



基本信息:
--

* Version 1.0 
* [REST API docs] 待定
* APP Entrance:  

### 开发环境搭建 ###

- 准备工作 [Elasticsearch镜像使用说明](Elastic.md)
 
-  Java API [6.4.x](https://www.elastic.co/guide/en/elasticsearch/client/java-api/current/index.html)

-  REST API [6.4.x](https://www.elastic.co/guide/en/elasticsearch/reference/current/index.html)

-  配置

找到项目的application.properties文件, 把下面的URL换成你在第一步搭建环境 Elasticsearch 的服务url

```
elastic.contextPath=http://192.168.1.30:9200
 
```
 

###  快速测试 ###

-  编译jar包

```
build.bat
```

-  执行 jar 包

在 ...\limscloud\logger\logger\build\libs 下面找到 logger-1.0.jar 

打开命令行环境, 切换到上面这个目录下面. ```  cd  xxxxxx ``` , 然后执行下面的命令.

```
 java -jar  logger-1.0.jar
```
-  浏览器里面验证
   * [REST API docs](http://localhost/swagger-ui.html) 
   * APP Entrance: http://localhost/swagger-ui.html 

   
 
 
  
### 参考文献 ###

Docker 官方镜像

https://docs.docker.com/samples/library/elasticsearch/

https://github.com/docker-library/elasticsearch

https://www.elastic.co/guide/en/elasticsearch/reference/current/getting-started.html


中文指南 
https://www.jianshu.com/p/fa31f38d241e

http://www.ruanyifeng.com/blog/2017/08/elasticsearch.html

http://www.cnblogs.com/guochunguang/articles/3641008.html
  