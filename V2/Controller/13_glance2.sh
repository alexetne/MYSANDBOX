#!/bin/bash
source .env

. /opt/admin-openrc

cat .env | grep GLANCE_PASS
openstack user create --domain default --password-prompt glance

openstack role add --project service --user glance admin
openstack service create --name glance --description "OpenStack Image" image

cat << EOF 


récuperez l'ID de l'endpoint ci DESSOUS !!!!!!!!!!!!!!!!!!!!
EOF
openstack endpoint create --region RegionOne image public http://controller:9292
cat << EOF
récuperez l'ID de l'endpoint ci DESSUS !!!!!!!!!!!!!!!!!!!!



EOF
openstack endpoint create --region RegionOne image internal http://controller:9292
openstack endpoint create --region RegionOne image admin http://controller:9292

apt install glance -y

cat << EOF

${GLANCE_CONF}

[database]
connection = mysql+pymysql://glance:${GLANCE_DBPASS}@controller/glance

[keystone_authtoken]
# ...
www_authenticate_uri  = http://controller:5000
auth_url = http://controller:5000
memcached_servers = controller:11211
auth_type = password
project_domain_name = Default
user_domain_name = Default
project_name = service
username = glance
password = ${GLANCE_PASS}

[paste_deploy]
# ...
flavor = keystone

[DEFAULT]
# ...
enabled_backends=fs:file

[glance_store]
# ...
default_backend = fs

[fs]
filesystem_store_datadir = /var/lib/glance/images/






[oslo_limit]
auth_url = http://controller:5000
auth_type = password
user_domain_id = default
username = glance
system_scope = all
password = ${GLANCE_PASS}
endpoint_id = ID NOTE PRECEDEMMENT
region_name = RegionOne

EOF

openstack role add --user glance --user-domain Default --system all reader
su -s /bin/sh -c "glance-manage db_sync" glance

service glance-api restart

