#!/bin/bash
source .env

. /opt/admin-openrc


unset OS_AUTH_URL OS_PASSWORD
echo "MDP ADMIN"
echo $ADMIN_PASS
echo ""
echo ""
openstack --os-auth-url http://controller:5000/v3 --os-project-domain-name Default --os-user-domain-name Default --os-project-name admin --os-username admin token issue

openstack --os-auth-url http://controller:5000/v3 --os-project-domain-name Default --os-user-domain-name Default --os-project-name myproject --os-username myuser token issue


echo "test du openrc"

. /opt/admin-openrc
openstack token issue
