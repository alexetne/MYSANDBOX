#!/bin/bash
source .env

cat ${ETCD_CONF} | grep ETCD_NAME
cat ${ETCD_CONF} | grep ETCD_DATA_DIR
cat ${ETCD_CONF} | grep ETCD_INITIAL_CLUSTER_STATE
cat ${ETCD_CONF} | grep ETCD_INITIAL_CLUSTER_TOKEN
cat ${ETCD_CONF} | grep ETCD_INITIAL_CLUSTER
cat ${ETCD_CONF} | grep ETCD_INITIAL_ADVERTISE_PEER_URLS
cat ${ETCD_CONF} | grep ETCD_ADVERTISE_CLIENT_URLS
cat ${ETCD_CONF} | grep ETCD_LISTEN_PEER_URLS
cat ${ETCD_CONF} | grep ETCD_LISTEN_CLIENT_URLS

systemctl enable etcd
systemctl restart etcd

echo "CREATE DATABASE keystone;" > ${SQL_KEYSTONE}
echo "CREATE USER 'keystone'@'localhost' IDENTIFIED BY \'${KEYSTONE_DBPASS}\';" >> ${SQL_KEYSTONE}
echo "GRANT ALL PRIVILEGES ON keystone.* TO 'keystone'@'localhost';" >> ${SQL_KEYSTONE}
echo "CREATE USER 'keystone'@'%' IDENTIFIED BY '\'${KEYSTONE_DBPASS}\';" >> ${SQL_KEYSTONE}
echo "GRANT ALL PRIVILEGES ON keystone.* TO 'keystone'@'%';" >> ${SQL_KEYSTONE}

cat <<EOF
Saisissez ceci dans MySQL :

CREATE DATABASE keystone;
CREATE USER 'keystone'@'localhost' IDENTIFIED BY '${KEYSTONE_DBPASS}';
GRANT ALL PRIVILEGES ON keystone.* TO 'keystone'@'localhost';
CREATE USER 'keystone'@'%' IDENTIFIED BY '${KEYSTONE_DBPASS}';
GRANT ALL PRIVILEGES ON keystone.* TO 'keystone'@'%';
EOF
