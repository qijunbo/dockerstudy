Dokcer 镜像开发人员学习手册
==

日志管理用于记录日志, 并提供全文检索. 本方案采用Elasticsearch全文搜索引擎.
本方案采用Dockers官方提供的Elasticsearch镜像作为后台服务, 但是为了增加易用性, 本项目对Elasticsearch做了封装.

 
开发环境搭建
--

该环境依赖Linux操作系统. 请使用前先安装好Docker.

- 启动服务

运行elasticsearch官方提供的Docker镜像.
```
mkdir esdata
docker run --name elastic -d -v "$PWD/esdata":/usr/share/elasticsearch/data -p 9200:9200 elasticsearch

或者
mkdir -p /opt/logger/esdata
docker run --name elastic -d -v "/opt/logger/esdata":/usr/share/elasticsearch/data -p 9200:9200 elasticsearch
```

- 测试 

插入数据 
```
curl -X PUT 'localhost:9200/accounts/person/1' -d '
{
  "user": "张三",
  "title": "工程师",
  "desc": "数据库管理"
}' 

curl -X POST 'localhost:9200/accounts/person' -d '
{
  "user": "李四",
  "title": "工程师",
  "desc": "系统管理"
}'

``` 

查询数据

```
curl -X POST 'localhost:9200/accounts/person/_search'  -d '
{
  "query" : { "match" : { "desc" : "数据库" }}
}'


```


  
### 参考文献 ###

Docker 官方镜像

https://docs.docker.com/samples/library/elasticsearch/

https://github.com/docker-library/elasticsearch

https://www.elastic.co/guide/en/elasticsearch/reference/current/getting-started.html


中文指南 

http://www.ruanyifeng.com/blog/2017/08/elasticsearch.html

http://www.cnblogs.com/guochunguang/articles/3641008.html

https://www.yiibai.com/elasticsearch/elasticsearch_query_dsl.html
  