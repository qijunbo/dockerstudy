安装指南
==

- [CentOS](https://docs.docker.com/engine/installation/linux/docker-ce/centos/)

- [Ubuntu](https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/)

傻瓜指南
--

- 删除旧版本, 如果有. 

```
yum remove docker  docker-common  docker-selinux docker-engine
```

- 列出最新可用stable版本

```
[root@localhost ~]#  yum list docker-ce --showduplicates | sort -r
Repodata is over 2 weeks old. Install yum-cron? Or run: yum makecache fast
Loaded plugins: fastestmirror, langpacks
## 数据太老了,  那就按上面的提示执行一下 yum makecache fast
Installed Packages
docker-ce.x86_64            17.06.0.ce-1.el7.centos             docker-ce-stable
docker-ce.x86_64            17.06.0.ce-1.el7.centos             docker-ce-edge
docker-ce.x86_64            17.06.0.ce-1.el7.centos             @docker-ce-edge
docker-ce.x86_64            17.05.0.ce-1.el7.centos             docker-ce-edge
docker-ce.x86_64            17.04.0.ce-1.el7.centos             docker-ce-edge
docker-ce.x86_64            17.03.2.ce-1.el7.centos             docker-ce-stable
docker-ce.x86_64            17.03.1.ce-1.el7.centos             docker-ce-stable
docker-ce.x86_64            17.03.0.ce-1.el7.centos             docker-ce-stable
Determining fastest mirrors
Available Packages
```
- 数据太老了,  那就按上面的提示执行一下 ``` yum makecache fast ```

```
[root@localhost ~]# yum makecache fast
Loaded plugins: fastestmirror, langpacks
Repodata is over 2 weeks old. Install yum-cron? Or run: yum makecache fast
base                                                 | 3.6 kB  00:00:00
docker-ce-e                                          | 2.9 kB  00:00:00
docker-ce-s                                          | 2.9 kB  00:00:00
extras                                               | 3.4 kB  00:00:00
mongodb-org                                          | 2.5 kB  00:00:00
updates                                              | 3.4 kB  00:00:00
(1/7): base/7/x86_64/group_gz                        | 156 kB  00:00:00
(2/7): extras/7/x86_64/primary_db                    | 145 kB  00:00:00
(3/7): docker-ce-edge/x86_64/primary_db              |  11 kB  00:00:02
(4/7): docker-ce-stable/x86_64/primary_db            |  10 kB  00:00:03
(5/7): base/7/x86_64/primary_db                      | 5.7 MB  00:00:04
(6/7): mongodb-org-3.4/7/primary_db                  |  48 kB  00:00:05
(7/7): updates/7/x86_64/primary_db                   | 4.6 MB  00:00:05
Loading mirror speeds from cached hostfile
Metadata Cache Created
```
- 再执行一下``` yum list docker-ce --showduplicates | sort -r ``` ,  我滴个乖乖, 最新版都新成这样了.

```
[root@localhost ~]# yum list docker-ce --showduplicates | sort -r | grep stable
docker-ce.x86_64            17.09.1.ce-1.el7.centos             docker-ce-stable
docker-ce.x86_64            17.09.0.ce-1.el7.centos             docker-ce-stable
docker-ce.x86_64            17.06.2.ce-1.el7.centos             docker-ce-stable
docker-ce.x86_64            17.06.1.ce-1.el7.centos             docker-ce-stable
docker-ce.x86_64            17.06.0.ce-1.el7.centos             docker-ce-stable
docker-ce.x86_64            17.03.2.ce-1.el7.centos             docker-ce-stable
docker-ce.x86_64            17.03.1.ce-1.el7.centos             docker-ce-stable
docker-ce.x86_64            17.03.0.ce-1.el7.centos             docker-ce-stable

```
> 请将版本字符串附加到包名称，并用连字符（-）分隔, 这样你就得到了完整的版本号:  docker-ce-17.09.1.ce-1.el7.centos 

- 如果是生产环境, 安装时**务必**带上版本号, 并且是stable 版本的, 否则各种奇奇怪怪的bug, 你就好好享受吧.

```
 yum install -y  docker-ce-17.09.1.ce-1.el7.centos
```

- 安装完了,验证一下

```
systemctl start docker
docker -v 
```

从国内到docker官方registry拉镜像很慢, 国内有加速镜像网站

CentOS7 最新的docker配置文件在这里。

vim /etc/docker/daemon.json

粘贴如下内容：
网易的
{
 "registry-mirrors": ["http://hub-mirror.c.163.com"],
 "live-restore": true
}

阿里的。
{
  "registry-mirrors": ["https://jcgiimz8.mirror.aliyuncs.com"]
}

这个测试过, 正在用:

{
  "registry-mirrors": ["https://q51d5nz8.mirror.aliyuncs.com"]
}


sudo systemctl daemon-reload
sudo service docker restart			  