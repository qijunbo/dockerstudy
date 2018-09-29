#!/bin/bash
docker run --name nginx -v /etc/nginx/conf.d:/etc/nginx/conf.d:ro -d -p 80:80 nginx
 