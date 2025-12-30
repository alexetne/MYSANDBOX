#!/bin/bash
source .env
. /opt/admin-openrc


service nova-compute restart
service neutron-openvswitch-agent restart