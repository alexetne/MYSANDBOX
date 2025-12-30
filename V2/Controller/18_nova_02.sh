#!/bin/bash
source .env

. /opt/admin-openrc
echo $NOVA_PASS
openstack user create --domain default --password-prompt nova
openstack role add --project service --user nova admin
openstack service create --name nova --description "OpenStack Compute" compute

openstack endpoint create --region RegionOne compute public http://controller:8774/v2.1
openstack endpoint create --region RegionOne compute internal http://controller:8774/v2.1
openstack endpoint create --region RegionOne compute admin http://controller:8774/v2.1

apt install nova-api nova-conductor nova-novncproxy nova-scheduler -y

cat << EOF

Edit the $NOVA_CONF
[api_database]
# ...
connection = mysql+pymysql://nova:${NOVA_DBPASS}@controller/nova_api

[database]
# ...
connection = mysql+pymysql://nova:${NOVA_DBPASS}@controller/nova
[DEFAULT]
# ...
transport_url = rabbit://openstack:${RABBIT_PASS}@controller:5672/
[api]
# ...
auth_strategy = keystone

[keystone_authtoken]
# ...
www_authenticate_uri = http://controller:5000/
auth_url = http://controller:5000/
memcached_servers = controller:11211
auth_type = password
project_domain_name = Default
user_domain_name = Default
project_name = service
username = nova
password = ${NOVA_PASS}

[service_user]
send_service_user_token = true
auth_url = https://controller/identity
auth_strategy = keystone
auth_type = password
project_domain_name = Default
project_name = service
user_domain_name = Default
username = nova
password = ${NOVA_PASS}

[DEFAULT]
# ...
my_ip = ${CONTROLLER_IP}

[vnc]
enabled = true
# ...
server_listen = \$my_ip
server_proxyclient_address = \$my_ip

[glance]
# ...
api_servers = http://controller:9292

[oslo_concurrency]
# ...
lock_path = /var/lib/nova/tmp

[placement]
# ...
region_name = RegionOne
project_domain_name = Default
project_name = service
auth_type = password
user_domain_name = Default
auth_url = http://controller:5000/v3
username = placement
password = ${PLACEMENT_PASS}



SUPPRIMER LA CASE default.log_dir


EOF