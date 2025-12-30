#!/bin/bash
source .env
cat <<EOF >> $HOST_CONF

$CONTROLLER_IP controller
$COMPUTE_IP compute
EOF