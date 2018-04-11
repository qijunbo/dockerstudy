


参考文献：
--

Docker https://docs.docker.com/samples/library/solr/

Github https://github.com/docker-solr/docker-solr


Solr
==

```
docker run --name solr -d -p 8983:8983 -t solr

docker run --name solr -d  -p 8983:8983 solr solr-create -c estandard
			
docker run --name solr \
            -v /opt/solr/server/solr/estandard:/opt/solr/server/solr/estandard \
            -d  -p 8983:8983 solr solr-create -c estandard
			
			
docker run --name solr \
       -v /opt/solr/server/solr/estandard:/opt/solr/server/solr/estandard \
       -d -p 8983:8983 -t solr		
 
``` 