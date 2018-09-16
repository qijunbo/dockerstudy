#!/bin/sh
docker stack deploy -c stack.yml mysql 
#(or docker-compose -f stack.yml up)