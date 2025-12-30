#!/bin/bash


########
#
# Install and configure keystone
#
########

echo "CREATE DATABASE keystone;" > $sql_keystone
echo "CREATE USER 'keystone'@'localhost' IDENTIFIED BY \'$KEYSTONE_DBPASS\';" >> $sql_keystone
echo "GRANT ALL PRIVILEGES ON keystone.* TO 'keystone'@'localhost';" >> $sql_keystone
echo "CREATE USER 'keystone'@'%' IDENTIFIED BY '\'$KEYSTONE_DBPASS\';" >> $sql_keystone
echo "GRANT ALL PRIVILEGES ON keystone.* TO 'keystone'@'%';" >> $sql_keystone

mysql < $sql_keystone


apt install keystone

cp $keystone_conf /etc/keystone/keystone.conf.old
