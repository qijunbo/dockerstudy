安装指南
==

- [CentOS](https://docs.docker.com/engine/installation/linux/docker-ce/centos/)

- [Ubuntu](https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/)

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