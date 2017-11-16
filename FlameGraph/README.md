Fire Graph
==

-  Capture stacks

For example,  I want capture the statcks of  tomcat which listen on port 8080, this is the way to find it's PID.

```
# netstat -nlpt | grep 8080
tcp        0      0 0.0.0.0:8080            0.0.0.0:*               LISTEN      14686/java

```
Using Linux perf_events (aka "perf") to capture 60 seconds of 99 Hertz stack samples, both user- and kernel-level stacks
process 3627

```
# perf record -F 99 -p 14686 -g -- sleep 60  && perf script > out.perf

```

- Fold stacks

Use the stackcollapse programs to fold stack samples into single lines. 

```
[root@local firegraph]# cd FlameGraph/
[root@local FlameGraph]# ./stackcollapse-perf.pl ../out.perf > ../out.folded
```

- flamegraph.pl

```
./flamegraph.pl ../out.folded > ../kernel.svg
cd ..

```



Reference
--

https://github.com/qijunbo/FlameGraph

http://www.ruanyifeng.com/blog/2017/09/flame-graph.html

http://man.linuxde.net/pgrep 

https://jingyan.baidu.com/article/4f34706e3ec075e387b56df2.html
