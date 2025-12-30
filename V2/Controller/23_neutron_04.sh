#!/bin/bash
source .env

. /opt/admin-openrc

cat <<EOF
/etc/neutron/plugins/ml2/openvswitch_agent.ini 

[ovs]
bridge_mappings = provider:$PROVIDER_BRIDGE_NAME
local_ip = $CONTROLLER_IP

EOF