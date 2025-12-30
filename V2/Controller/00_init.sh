#!/bin/bash

# INIT PASSWORD

ADMIN_PASS="$(openssl rand -hex 10)"
CINDER_DBPASS="$(openssl rand -hex 10)"
CINDER_PASS="$(openssl rand -hex 10)"
DASH_DBPASS="$(openssl rand -hex 10)"
DEMO_PASS="$(openssl rand -hex 10)"
GLANCE_DBPASS="$(openssl rand -hex 10)"
GLANCE_PASS="$(openssl rand -hex 10)"
KEYSTONE_DBPASS="$(openssl rand -hex 10)"
METADATA_SECRET="$(openssl rand -hex 10)"
NEUTRON_DBPASS="$(openssl rand -hex 10)"
NEUTRON_PASS="$(openssl rand -hex 10)"
NOVA_DBPASS="$(openssl rand -hex 10)"
NOVA_PASS="$(openssl rand -hex 10)"
PLACEMENT_PASS="$(openssl rand -hex 10)"
RABBIT_PASS="$(openssl rand -hex 10)"
PLACEMENT_DBPASS="$(openssl rand -hex 10)"

# Reset .env
: > .env

echo "ADMIN_PASS=${ADMIN_PASS}" >> .env
echo "CINDER_DBPASS=${CINDER_DBPASS}" >> .env
echo "CINDER_PASS=${CINDER_PASS}" >> .env
echo "DASH_DBPASS=${DASH_DBPASS}" >> .env
echo "DEMO_PASS=${DEMO_PASS}" >> .env
echo "GLANCE_DBPASS=${GLANCE_DBPASS}" >> .env
echo "GLANCE_PASS=${GLANCE_PASS}" >> .env
echo "KEYSTONE_DBPASS=${KEYSTONE_DBPASS}" >> .env
echo "METADATA_SECRET=${METADATA_SECRET}" >> .env
echo "NEUTRON_DBPASS=${NEUTRON_DBPASS}" >> .env
echo "NEUTRON_PASS=${NEUTRON_PASS}" >> .env
echo "NOVA_DBPASS=${NOVA_DBPASS}" >> .env
echo "NOVA_PASS=${NOVA_PASS}" >> .env
echo "PLACEMENT_PASS=${PLACEMENT_PASS}" >> .env
echo "RABBIT_PASS=${RABBIT_PASS}" >> .env
echo "PLACEMENT_DBPASS=${PLACEMENT_DBPASS}" >> .env
echo "" >> .env

# INIT NETWORK
# IP address: 10.10.0.X
# Network mask: 255.255.255.0 (/24)
# Default gateway: 10.10.0.254

echo "NETWORK=10.10.0.0/24" >> .env
echo "NETMASK=255.255.255.0" >> .env
echo "GATEWAY=10.10.0.254" >> .env

echo "CONTROLLER_IP=10.10.0.100" >> .env
echo "COMPUTE_IP=10.10.0.6" >> .env

echo "CHRONY_CONF=/etc/chrony/chrony.conf" >> .env
echo "HOST_CONF=/etc/hosts" >> .env
echo "MARIADB_CONF=/etc/mysql/mariadb.conf.d/99-openstack.cnf" >> .env
echo "MEMCACHED_CONF=/etc/memcached.conf" >> .env
echo "ETCD_CONF=/etc/default/etcd" >> .env
echo "KEYSTONE_CONF=/etc/keystone/keystone.conf" >> .env
echo "GLANCE_CONF=/etc/glance/glance-api.conf" >> .env
echo "PLACEMENT_CONF=/etc/placement/placement.conf" >> .env
echo "NOVA_CONF=/etc/nova/nova.conf" >> .env
echo "NEUTRON_CONF=/etc/neutron/neutron.conf" >> .env




echo "SQL_KEYSTONE=./sql_keystone.sql" >> .env
echo "SQL_GLANCE=./sql_glance.sql" >> .env
echo "SQL_PLACEMENT=./sql_placement.sql" >> .env
echo "SQL_NOVA=./sql_nova.sql" >> .env
echo "SQL_NEUTRON=./sql_neutron.sql" >> .env

echo "PROVIDER_BRIDGE_NAME=br-provider" >> .env
echo "PROVIDER_INTERFACE_NAME=eth1" >> .env

