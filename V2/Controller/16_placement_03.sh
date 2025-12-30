#!/bin/bash
source .env

. /opt/admin-openrc


su -s /bin/sh -c "placement-manage db sync" placement

placement-status upgrade check
openstack --os-placement-api-version 1.2 resource class list --sort-column name
openstack --os-placement-api-version 1.6 trait list --sort-column name