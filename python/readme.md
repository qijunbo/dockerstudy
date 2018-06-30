Python
==

安装依赖模块 mysql-python

No module named MYSQLdb 问题解决
问题描述：
报错：ImportError: No module named MySQLdb

对于不同的系统和程序有如下的解决方法：
```
easy_install mysql-python (mix os)
pip install mysql-python (mix os)
apt-get install python-mysqldb (Linux Ubuntu)
cd/usr/ports/databases/py-MySQLdb && make install clean (FreeBSD)
yum install MySQL-python (linux Fedora, CentOS)
pip install mysqlclient (Windows)
```


Reference
==

https://www.cnblogs.com/dreamer-fish/p/3820625.html

https://www.cnblogs.com/conanwang/p/6028110.html