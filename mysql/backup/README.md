mysql 备份恢复策略
==

> 注意, 文件 docker.cnf 比外面的文件多了一个 log-bin 配置项, 开启这个配置项的效果是:  mysqld 会启动增量备份. 详见: mysql5.7.x版官方文档, 5.4.4 章节.


全量备份
--

```
 backupfully.sh  containerName
```
其中 containerName 是mysql docker 容器的名字.

docker 官方推荐的备份方式:

```
docker exec mysql sh -c 'exec mysqldump --all-databases -uroot -p"$MYSQL_ROOT_PASSWORD"' > /some/path/on/your/host/all-databases.sql

docker exec mmwiki_db_1 sh -c 'exec mysqldump mm_wiki -uroot -psunway123###' > /root/docker/mm_wiki/mm_wiki.sql
```


数据恢复
--

恢复的时候, 你就没法在容器的外面进行了, 先登入容器内部, 然后恢复数据, 如下:

```
docker exec -it containerName bash
cd /var/lib/mysql/backup
mysql -u root -p database_name < backup-xxxx.sql
```

增量备份
--
正如本文开头所说, myaql的启动配置文件, 加那么一项, 增量备份就自动进行了.  那我们还用干啥呢?

就把它copy到安全的地方就结了呗.


增量恢复
--
```
(4)使用mysqlbinlog 恢复mysqldump 备份以来的BINLOG
#mysqlbinlog mysql-bin.000012 |mysql -uroot -p student
查询完全恢复后的数据:
mysql> select * from s;
+------+-------+------+-----------+
| sno  | sname | sex  | address   |
+------+-------+------+-----------+
| 0901 | Jim   | 1    | shanghai  |
| 0902 | helun | 2    | beijing   |
| 0903 | sam   | 1    | sichuan   |
| 0904 | keke  | 1    | xizang    |
| 0905 | gugu  | 1    | suzhou    |
| 0906 | tang  | 2    | guangdong |
| 0907 | liu   | 1    | jiangxi   |
| 0908 | wang  | 2    | wuxi      |
+------+-------+------+-----------+
8 rows in set (0.00 sec)
恢复完成!
 
基于时间点的恢复(不完全恢复)
由于误操作,比如删除了一张表,使用完全恢复是没有用的,我们需要的是恢复到误操作之前的状态,然后跳过误操作语句,再恢复后面执行的语句,完成恢复;
例:
(1)上午10点发生误操作,可以用如下语句备份和BINLOG将数据恢复到故障前
#mysqlbinlog --stop-date="2010-10-31 9:59:59" /usr/local/mysql/var/mysql-bin.000013 |mysql -uroot -p
 
 
(2)跳过故障时间点,继续执行后面的BINLOG,完成恢复
#mysqlbinlog --start-date="2010-10-31 10:01:00" /usr/local/mysql/var/mysql-bin.000013 |mysql -uroot -p
 
基于位置恢复(不完全恢复)
和基于时间点恢复类是,但是更加精确.因为同一时间点可能有多条SQL语句执行;
例:
#mysqlbinlog --start-date="2010-10-31 9:55:00"  --stop-date="2010-10-31 10:05:00" /usr/local/mysql/var/mysql-bin.000013 > /tmp/mysql_restore.sql
 
该命令将在/tmp/目录下创建小的文件,编辑它找到错误语句前后的位置号,例如前后位置号分别是368312 和 368315
(2)恢复了以前的备份文件后,输入
#mysqlbinlog --stop-position="368312" /usr/local/mysql/var/mysql-bin.000013 |mysql -uroot -p
 
#mysqlbinlog --start-position="368315" /usr/local/mysql/var/mysql-bin.000013 |mysql -uroot -p
```