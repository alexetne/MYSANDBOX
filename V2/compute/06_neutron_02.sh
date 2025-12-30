#!/bin/bash
source .env
. /opt/admin-openrc


cat <<EOF

/etc/neutron/plugins/ml2/openvswitch_agent.ini

[agent]
tunnel_types = vxlan
l2_population = true

[securitygroup]
# ...
enable_security_group = true
firewall_driver = openvswitch
#firewall_driver = iptables_hybrid



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

EOF

