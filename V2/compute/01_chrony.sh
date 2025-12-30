#!/bin/bash
source .env

cat <<EOF >> $HOST_CONF

$CONTROLLER_IP controller
$COMPUTE_IP compute
EOF

apt install chrony -y

cat <<EOF 
editez $CHRONY_CONF

server controller iburst

Comment out the pool 2.debian.pool.ntp.org offline iburst line
EOF