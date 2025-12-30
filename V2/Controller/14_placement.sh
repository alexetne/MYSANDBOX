#!/bin/bash
source .env

. /opt/admin-openrc


cat << EOF > ${SQL_PLACEMENT}
CREATE DATABASE placement;
GRANT ALL PRIVILEGES ON placement.* TO 'placement'@'localhost' IDENTIFIED BY '${PLACEMENT_DBPASS}';
GRANT ALL PRIVILEGES ON placement.* TO 'placement'@'%' IDENTIFIED BY '${PLACEMENT_DBPASS}';
EOF

cat << EOF

copiez collez ceci dans MySQL :
$(cat ${SQL_PLACEMENT})

EOF


