#!/bin/bash
source .env

. /opt/admin-openrc

cat <<EOF

/etc/neutron/metadata_agent.ini

[DEFAULT]
# ...
nova_metadata_host = controller
metadata_proxy_shared_secret = $METADATA_SECRET



/etc/nova/nova.conf

[neutron]
# ...
auth_url = http://controller:5000
auth_type = password
project_domain_name = Default
user_domain_name = Default
region_name = RegionOne
project_name = service
username = neutron
password = $NEUTRON_PASS
service_metadata_proxy = true
metadata_proxy_shared_secret = $METADATA_SECRET




ALLEZ SUR LE COMPUTE ET FAITES LE 05_NEUTRON
EOF