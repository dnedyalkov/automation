#!/bin/bash
# Database credentials
user="root"
password=""
host="127.0.0.1"
db_name="test"
auth_db="admin"

# Other options
backup_path="/backups"
date=$(date +"%Y-%m-%d")

# Set default file permissions
umask 177

# Dump database into folder
mongodump --quiet --db ufeelme --host=$host --username $user --password $password --authenticationDatabase $auth_db -o $backup_path/$db_name-$date

# archive dump folder
cd $backup_path
tar czf $db_name-$date.tar.gz $db_name-$date

# remove dump folder
rm -rf $db_name-$date

# Change permissions
chmod 0644 $db_name-$date.tar.gz

# Delete files older than 30 days
find $backup_path/* -mtime +30 -exec rm {} \;