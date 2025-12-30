#!/bin/bash
source .env

add-apt-repository cloud-archive:epoxy
apt install python3-openstackclient -y