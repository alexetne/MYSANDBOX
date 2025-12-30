#!/bin/bash
source .env

. /opt/admin-openrc

echo $NEUTRON_PASS
openstack user create --domain default --password-prompt neutron
openstack role add --project service --user neutron admin
openstack service create --name neutron --description "OpenStack Networking" network

openstack endpoint create --region RegionOne network public http://controller:9696
openstack endpoint create --region RegionOne network internal http://controller:9696
openstack endpoint create --region RegionOne network admin http://controller:9696

zypper install --no-recommends openstack-neutron \
  openstack-neutron-server openstack-neutron-openvswitch-agent \
  openstack-neutron-l3-agent openstack-neutron-dhcp-agent \
  openstack-neutron-metadata-agent bridge-utils dnsmasq


apt install neutron-server neutron-plugin-ml2 \
  neutron-openvswitch-agent neutron-l3-agent neutron-dhcp-agent \
  neutron-metadata-agent -y

cat <<EOF







/etc/neutron/neutron.conf

[database]
# ...
connection = mysql+pymysql://neutron:$NEUTRON_DBPASS@controller/neutron

[DEFAULT]
# ...
core_plugin = ml2
service_plugins = router

[DEFAULT]
# ...
transport_url = rabbit://openstack:$RABBIT_PASS@controller
auth_strategy = keystone
notify_nova_on_port_status_changes = true
notify_nova_on_port_data_changes = true

[keystone_authtoken]
# ...
www_authenticate_uri = http://controller:5000
auth_url = http://controller:5000
memcached_servers = controller:11211
auth_type = password
project_domain_name = Default
user_domain_name = Default
project_name = service
username = neutron
password = $NEUTRON_PASS

[nova]
# ...
auth_url = http://controller:5000
auth_type = password
project_domain_name = Default
user_domain_name = Default
region_name = RegionOne
project_name = service
username = nova
password = $NOVA_PASS

[oslo_concurrency]
# ...
lock_path = /var/lib/neutron/tmp

EOF