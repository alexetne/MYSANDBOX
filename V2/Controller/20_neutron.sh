#!/bin/bash
source .env

. /opt/admin-openrc

cat << EOF > ${SQL_NEUTRON}
CREATE DATABASE neutron;
GRANT ALL PRIVILEGES ON neutron.* TO 'neutron'@'localhost' IDENTIFIED BY '$NEUTRON_DBPASS';
GRANT ALL PRIVILEGES ON neutron.* TO 'neutron'@'%' IDENTIFIED BY '$NEUTRON_DBPASS';
EOF

cat << EOF
Copiez collez ceci dans MySQL :
$(cat ${SQL_NEUTRON})

EOF