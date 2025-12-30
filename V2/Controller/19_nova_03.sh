#!/bin/bash
source .env

. /opt/admin-openrc

su -s /bin/sh -c "nova-manage api_db sync" nova
su -s /bin/sh -c "nova-manage cell_v2 map_cell0" nova
su -s /bin/sh -c "nova-manage cell_v2 create_cell --name=cell1 --verbose" nova
su -s /bin/sh -c "nova-manage db sync" nova

su -s /bin/sh -c "nova-manage cell_v2 list_cells" nova
service nova-api restart
service nova-scheduler restart
service nova-conductor restart
service nova-novncproxy restart

cat <<EOF
Assurez vous d'avoir initié 1 noeud à minima avant de continuer
EOF

openstack compute service list --service nova-compute

su -s /bin/sh -c "nova-manage cell_v2 discover_hosts --verbose" nova