mkdir -p /opt/logger/esdata
docker run --name elastic -d  --restart=always -v "/opt/logger/esdata":/usr/share/elasticsearch/data -p 9200:9200 elasticsearch


