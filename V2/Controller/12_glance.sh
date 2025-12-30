#!/bin/bash
source .env

. /opt/admin-openrc


cat <<EOF > ${SQL_GLANCE}

CREATE DATABASE glance;
GRANT ALL PRIVILEGES ON glance.* TO 'glance'@'localhost' IDENTIFIED BY '${GLANCE_DBPASS}';
GRANT ALL PRIVILEGES ON glance.* TO 'glance'@'%' IDENTIFIED BY '${GLANCE_DBPASS}';

EOF

cat << EOF
Copiez collez ceci dans MySQL :
$(cat ${SQL_GLANCE})
EOF
