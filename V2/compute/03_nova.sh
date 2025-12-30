#!/bin/bash
source .env

cat << EOF > /opt/admin-openrc
export OS_PROJECT_DOMAIN_NAME=Default
export OS_USER_DOMAIN_NAME=Default
export OS_PROJECT_NAME=admin
export OS_USERNAME=admin
export OS_PASSWORD=${ADMIN_PASS}
export OS_AUTH_URL=http://controller:5000/v3
export OS_IDENTITY_API_VERSION=3
export OS_IMAGE_API_VERSION=2
EOF

apt install nova-compute -y

cat <<EOF
Edit the $NOVA_CONF

[DEFAULT]
# ...
transport_url = rabbit://openstack:${RABBIT_PASS}@controller

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
auth_url = http://controller/identity
auth_strategy = keystone
auth_type = password
project_domain_name = Default
project_name = service
user_domain_name = Default
username = nova
password = ${NOVA_PASS}

[DEFAULT]
# ...
my_ip = $COMPUTE_IP

[vnc]
# ...
enabled = true
server_listen = 0.0.0.0
server_proxyclient_address = \$my_ip
novncproxy_base_url = http://controller:6080/vnc_auto.html

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


EOF