#!/bin/bash
source .env

. /opt/admin-openrc

echo $PLACEMENT_PASS
openstack user create --domain default --password-prompt placement

openstack role add --project service --user placement admin
openstack service create --name placement --description "Placement API" placement

openstack endpoint create --region RegionOne placement public http://controller:8778
openstack endpoint create --region RegionOne placement internal http://controller:8778
openstack endpoint create --region RegionOne placement admin http://controller:8778

apt install placement-api -y

cat << EOF





Edit the $PLACEMENT_CONF

[placement_database]
# ...
connection = mysql+pymysql://placement:${PLACEMENT_DBPASS}@controller/placement

[api]
# ...
auth_strategy = keystone

[keystone_authtoken]
# ...
auth_url = http://controller:5000/v3
memcached_servers = controller:11211
auth_type = password
project_domain_name = Default
user_domain_name = Default
project_name = service
username = placement
password = ${PLACEMENT_PASS}


EOF