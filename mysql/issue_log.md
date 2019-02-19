[Warning] InnoDB: Table mysql/innodb_index_stats has length mismatch in the column name table_name.  Please run mysql_upgrade
==

报以上错误的时候, mysql 每几分钟就会出现一次 CPU 100% 的脉冲.

~~~

docker exec -it mysql  bash

mysql_upgrade -uroot -p'123456'

重启生效 (经验证, 没有重启也正常了)
service mysql stop
service mysql start
~~~