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
enable_security_group = true
firewall_driver = openvswitch
#firewall_driver = iptables_hybrid


/etc/neutron/l3_agent.ini

[DEFAULT]
interface_driver = openvswitch

/etc/neutron/dhcp_agent.ini

[DEFAULT]
# ...
dhcp_driver = neutron.agent.linux.dhcp.Dnsmasq
enable_isolated_metadata = true
interface_driver = openvswitch

/etc/neutron/metadata_agent.ini

[DEFAULT]
# ...
nova_metadata_host = controller
metadata_proxy_shared_secret = $METADATA_SECRET


/etc/nova/nova.conf

[neutron]
# ...
auth_url = http://controller:5000/v3
auth_type = password
project_domain_name = Default
user_domain_name = Default
region_name = RegionOne
project_name = service
username = neutron
password = $NEUTRON_PASS
service_metadata_proxy = true
metadata_proxy_shared_secret = $METADATA_SECRET

EOF
