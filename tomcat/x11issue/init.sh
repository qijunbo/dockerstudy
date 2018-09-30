#!/bin/sh
mkdir -p /docker/everyone/initsql
mkdir -p /docker/everyone/conf
cp -f init.sql  /docker/everyone/initsql/init.sql
cp -f docker.cnf /docker/everyone/conf/docker.cnf
echo "done!"
