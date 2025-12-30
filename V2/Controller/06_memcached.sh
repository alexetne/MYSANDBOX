#!/bin/bash
source .env

apt install memcached python3-memcache -y

cp ${MEMCACHED_CONF} /etc/memcached.conf.old

echo "remplassez -l 127.0.0.1 par -l $CONTROLLER_IP dans $MEMCACHED_CONF"
