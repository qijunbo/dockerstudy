systemctl stop nginx
docker stack rm swagger_demo
docker container prune -f 
systemctl start nginx
