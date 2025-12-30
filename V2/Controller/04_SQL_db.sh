#!/bin/bash
source .env

# Installation MariaDB
apt install -y mariadb-server python3-pymysql

# Configuration MariaDB (OpenStack)
{
  echo "[mysqld]"
  echo "bind-address = ${CONTROLLER_IP}"
  echo ""
  echo "default-storage-engine = innodb"
  echo "innodb_file_per_table = on"
  echo "max_connections = 4096"
  echo "collation-server = utf8_general_ci"
  echo "character-set-server = utf8"
} > "${MARIADB_CONF}"

# Redémarrage du service
service mysql restart

# Vérification du fichier de configuration
cat "${MARIADB_CONF}"
