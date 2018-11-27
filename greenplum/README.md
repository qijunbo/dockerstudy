Greenplum
==

- 这个不行, 跑不通 
```
docker run -it -p 5432:5432 --hostname=db_master_1 --name gpdb chadongstad/greenplum-docker bash
```

- 用 docker-compose up -d 启用下面那个版本.

### 测试连通性

- [驱动下载页面](https://jdbc.postgresql.org/download.html)  [[42.2.5]](https://jdbc.postgresql.org/download/postgresql-42.2.5.jre6.jar)



- port 5432 

- user/pass is gpadmin/dataroad

```
psql mydb

CREATE DATABASE mydb OWNER gpadmin;
```
Docker Image
==
[CentOS]
https://hub.docker.com/r/pivotaldata/centos-gpdb-dev/

docker pull pivotaldata/centos-gpdb-dev:7

docker run    --hostname=gplum  --name gpdb -P  pivotaldata/centos-gpdb-dev:7

[Ubuntu]
https://hub.docker.com/r/chadongstad/greenplum-docker/

[采用这版]
https://github.com/DataRoadTech/greenplum-docker

Reference:
==

裸机安装指南:
https://yq.aliyun.com/articles/609855
https://yq.aliyun.com/articles/585391

配置文件资源:
https://github.com/dbbaskette/gpdb-docker