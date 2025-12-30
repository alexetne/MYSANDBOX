#!/bin/bash
source .env

su -s /bin/sh -c "keystone-manage db_sync" keystone
keystone-manage fernet_setup --keystone-user keystone --keystone-group keystone
keystone-manage credential_setup --keystone-user keystone --keystone-group keystone

keystone-manage bootstrap --bootstrap-password ${ADMIN_PASS} --bootstrap-admin-url http://controller:5000/v3/ --bootstrap-internal-url http://controller:5000/v3/ --bootstrap-public-url http://controller:5000/v3/ --bootstrap-region-id RegionOne

cat <<EOF

Edit the /etc/apache2/apache2.conf file and configure the ServerName option to reference the controller node:
ServerName controller

EOF

systemctl restart apache2

export OS_USERNAME=admin
export OS_PASSWORD=${ADMIN_PASS}
export OS_PROJECT_NAME=admin
export OS_USER_DOMAIN_NAME=Default
export OS_PROJECT_DOMAIN_NAME=Default
export OS_AUTH_URL=http://controller:5000/v3
export OS_IDENTITY_API_VERSION=3

openstack domain create --description "An Example Domain" example

openstack project create --domain default --description "Service Project" service

openstack project create --domain default --description "Demo Project" myproject

openstack user create --domain default --password-prompt myuser

openstack role create myrole

openstack role add --project myproject --user myuser myrole

echo "" > /opt/admin-openrc
echo "" > /opt/demo-openrc

cat << EOF
copiez collez ceci dans /opt/admin-openrc :

export OS_PROJECT_DOMAIN_NAME=Default
export OS_USER_DOMAIN_NAME=Default
export OS_PROJECT_NAME=admin
export OS_USERNAME=admin
export OS_PASSWORD=${ADMIN_PASS}
export OS_AUTH_URL=http://controller:5000/v3
export OS_IDENTITY_API_VERSION=3
export OS_IMAGE_API_VERSION=2
EOF

cat << EOF
copiez collez ceci dans /opt/demo-openrc en prenant soins de changer demo_pass :

export OS_PROJECT_DOMAIN_NAME=Default
export OS_USER_DOMAIN_NAME=Default
export OS_PROJECT_NAME=myproject
export OS_USERNAME=myuser
export OS_PASSWORD=Passroot1!
export OS_AUTH_URL=http://controller:5000/v3
export OS_IDENTITY_API_VERSION=3
export OS_IMAGE_API_VERSION=2
EOF