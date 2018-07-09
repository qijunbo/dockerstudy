systemctl stop nginx
docker stop redis
docker rm redis
systemctl start nginx
docker run --name redis   --restart=always -d -p 6379:6379 sunway/redis 
