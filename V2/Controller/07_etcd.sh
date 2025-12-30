#!/bin/bash
source .env

cat ${MEMCACHED_CONF} | grep '-l'

service memcached restart

apt install etcd-server -y

cp ${ETCD_CONF} /etc/default/etcd.old

echo "saisissez ca dans ${ETCD_CONF}"

echo "ETCD_NAME=\"controller\""
echo "ETCD_DATA_DIR=\"/var/lib/etcd\""
echo "ETCD_INITIAL_CLUSTER_STATE=\"new\""
echo "ETCD_INITIAL_CLUSTER_TOKEN=\"etcd-cluster-01\""
echo "ETCD_INITIAL_CLUSTER=\"controller=http://${CONTROLLER_IP}:2380\""
echo "ETCD_INITIAL_ADVERTISE_PEER_URLS=\"http://${CONTROLLER_IP}:2380\""
echo "ETCD_ADVERTISE_CLIENT_URLS=\"http://${CONTROLLER_IP}:2379\""
echo "ETCD_LISTEN_PEER_URLS=\"http://0.0.0.0:2380\""
echo "ETCD_LISTEN_CLIENT_URLS=\"http://${CONTROLLER_IP}:2379\""
