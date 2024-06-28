#!/bin/bash

# Directory for backups
BACKUP_DIR="/opt/mysql_backups/$(date +%Y-%m-%d)"
mkdir -p ${BACKUP_DIR}

# MySQL credentials
MYSQL_USER="root"
MYSQL_PASSWORD="rootpassword"

# Databases to backup
DATABASES=$(mysql -u${MYSQL_USER} -p${MYSQL_PASSWORD} -e "SHOW DATABASES;" | tr -d "| " | grep -v Database)

# Backup each database
for DB in $DATABASES; do
  mysqldump -u${MYSQL_USER} -p${MYSQL_PASSWORD} --databases ${DB} > ${BACKUP_DIR}/${DB}.sql
done

# Remove backups older than 7 days
find /opt/mysql_backups/ -type d -mtime +7 -exec rm -rf {} \;
