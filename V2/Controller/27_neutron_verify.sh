#!/bin/bash
source .env

. /opt/admin-openrc


openstack extension list --network
openstack network agent list