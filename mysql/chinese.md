中文支持
==

查看mysql是否支持中文
==
```
mysql> show variables like '%character%';
```

看起来是这样
```
+--------------------------+----------------------------+
| Variable_name            | Value                      |
+--------------------------+----------------------------+
| character_set_client     | latin1                     |
| character_set_connection | latin1                     |
| character_set_database   | utf8                       |
| character_set_filesystem | binary                     |
| character_set_results    | latin1                     |
| character_set_server     | utf8                       |
| character_set_system     | utf8                       |
| character_sets_dir       | /usr/share/mysql/charsets/ |
+--------------------------+----------------------------+
8 rows in set (0.01 sec)
```

设置中文支持
==

```
set character_set_server=utf8;
set collation-server=utf8_general_ci;
```

通过修改配置文件来设置mysql所有新建的数据库都是支持中文的.

参考如下:  https://www.cnblogs.com/liyingxiang/p/5877764.html
 
```
[mysqld]
skip-host-cache
skip-name-resolve
lower_case_table_names = 1
max_connections=500
innodb_buffer_pool_size=5120M
innodb_buffer_pool_instances=5
default-time-zone=+8:00
character_set_server=utf8
collation-server=utf8_general_ci
```

其中于中文支持相关的必须包含如下两项
```
character_set_server=utf8
collation-server=utf8_general_ci
```
 

