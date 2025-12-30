#!/bin/bash
source .env

. /opt/admin-openrc

ovs-vsctl add-br $PROVIDER_BRIDGE_NAME
ovs-vsctl add-port $PROVIDER_BRIDGE_NAME $PROVIDER_INTERFACE_NAME

cat <<EOF
/etc/neutron/plugins/ml2/openvswitch_agent.ini

[agent]
tunnel_types = vxlan
l2_population = true

[securitygroup]
# ...
enable_security_group = true
firewall_driver = openvswitch


/etc/neutron/dhcp_agent.ini

[DEFAULT]
# ...
dhcp_driver = neutron.agent.linux.dhcp.Dnsmasq
enable_isolated_metadata = true

EOF