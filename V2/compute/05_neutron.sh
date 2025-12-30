#!/bin/bash
source .env
. /opt/admin-openrc

apt install neutron-openvswitch-agent -y

cat <<EOF

/etc/neutron/neutron.conf

the [database] section, comment out any connection options because compute nodes do not directly access the database.

[DEFAULT]
# ...
transport_url = rabbit://openstack:$RABBIT_PASS@controller

[oslo_concurrency]
# ...
lock_path = /var/lib/neutron/tmp



/etc/neutron/plugins/ml2/openvswitch_agent.ini
[ovs]
bridge_mappings = provider:$PROVIDER_BRIDGE_NAME
local_ip = $COMPUTE_IP

EOF
ovs-vsctl add-br $PROVIDER_BRIDGE_NAME
ovs-vsctl add-port $PROVIDER_BRIDGE_NAME $PROVIDER_INTERFACE_NAME
