#!/bin/bash
source .env

# Installation RabbitMQ
apt install -y rabbitmq-server

# Création de l’utilisateur OpenStack
rabbitmqctl add_user openstack "${RABBIT_PASS}"

# Attribution des permissions
rabbitmqctl set_permissions openstack ".*" ".*" ".*"
