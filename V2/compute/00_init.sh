#!/bin/bash

# INIT NETWORK
# IP address: 10.10.0.X
# Network mask: 255.255.255.0 (/24)
# Default gateway: 10.10.0.254

echo "NETWORK=10.10.0.0/24" >> .env
echo "NETMASK=255.255.255.0" >> .env
echo "GATEWAY=10.10.0.254" >> .env

echo "CONTROLLER_IP=10.10.0.100" >> .env
echo "COMPUTE_IP=10.10.0.6" >> .env

echo "NOVA_CONF=/etc/nova/nova.conf" >> .env
echo "CHRONY_CONF=/etc/chrony/chrony.conf" >> .env

echo "SQL_NOVA=./sql_nova.sql" >> .env

echo "HOST_CONF=/etc/hosts" >> .env


cat << EOF
Ajoutez les variables d'env MDP de la machine maitre
EOF
