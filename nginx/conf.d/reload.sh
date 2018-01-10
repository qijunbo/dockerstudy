#!/bin/bash
if [ -z "$1" ]; then
   echo "Usage $0 name"
   exit -1 ;
fi
docker exec -it $1 service nginx reload
