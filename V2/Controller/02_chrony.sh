#!/bin/bash
source .env

# Vérification des entrées hosts
grep "controller" "${HOST_CONF}"
grep "compute1" "${HOST_CONF}"
grep "block1" "${HOST_CONF}"
grep "object1" "${HOST_CONF}"
grep "object2" "${HOST_CONF}"

# Installation de chrony
apt install -y chrony

# Configuration chrony
grep -q "server ${CONTROLLER_IP}" "${CHRONY_CONF}" || \
  echo "server ${CONTROLLER_IP} iburst" >> "${CHRONY_CONF}"

grep -q "allow ${NETWORK}" "${CHRONY_CONF}" || \
  echo "allow ${NETWORK}" >> "${CHRONY_CONF}"

# Redémarrage du service
service chrony restart

# Vérification des sources NTP
chronyc sources
