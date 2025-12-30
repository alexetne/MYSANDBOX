#!/bin/bash
source .env

apt install keystone -y

cat <<EOF

/etc/keystone/keystone.conf

In the [database] section, configure database access:
[database]
# ...
connection = mysql+pymysql://keystone:${KEYSTONE_DBPASS}@controller/keystone


EOF

cat <<EOF

/etc/keystone/keystone.conf

In the [token] section, configure the Fernet token provider :
[token]
# ...
provider = fernet

EOF

