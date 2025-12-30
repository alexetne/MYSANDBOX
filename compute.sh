#!/bin/bash


#############################
#
#
# VARIABLES
#
#
#############################

# IP address: 10.10.0.X
# Network mask: 255.255.255.0 (or /24)
# Default gateway: 10.10.254

Network=10.10.0.0/24
Netmask=255.255.255.0
Gateway=10.10.0.254

controller_ip=10.10.0.6
compute1_ip=10.10.0.7
block1_ip=10.10.0.8
object1_ip=10.10.0.9
object2_ip=10.10.0.10

$host_conf=/etc/hosts
$chrony_CONF=/etc/chrony/chrony.conf

#############################
#
#
# Configure name resolution
#
#
#############################

echo "$controller_ip controller" >> $host_conf
echo "$compute1_ip compute1" >> $host_conf
echo "$block1_ip block1" >> $host_conf
echo "$object1_ip object1" >> $host_conf
echo "$object2_ip object2" >> $host_conf

#############################
#
#
# Chrony
#
#
#############################

# Install & configure Chrony

apt install chrony -y
echo "server controller iburst" >> $chrony_CONF

cp $chrony_CONF /etc/chrony/chrony.conf.old

sed -i \
  '/^[[:space:]]*#[[:space:]]*pool[[:space:]]\+2\.debian\.pool\.ntp\.org/d' \
  "$chrony_CONF"

sed -i \
  '/^[[:space:]]*pool[[:space:]]\+2\.debian\.pool\.ntp\.org[[:space:]]\+offline[[:space:]]\+iburst/s/^/#/' \
  "$chrony_CONF"

service chrony restart
systemctl enable chrony.service
systemctl start chrony.service



# Vérification de chrony 

chronyc sources


#####################
#
# OpenStack packages for Ubuntu
#
#####################

add-apt-repository cloud-archive:flamingo
apt install python3-openstackclient


