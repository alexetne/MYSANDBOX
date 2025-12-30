#!/bin/bash
source .env

service chrony restart

add-apt-repository cloud-archive:epoxy
apt install python3-openstackclient -y