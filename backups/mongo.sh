#!/bin/bash
# Database credentials
user="root"
password=""
host="127.0.0.1"
db_name="test"
auth_db="admin"

# Other options
backup_path="/backups"
date=$(date +"%Y-%b-%d")

# Set default file permissions
umask 177

# Dump database into archived file
mongodump --db ufeelme --host=$host --username $user --password $password --authenticationDatabase $auth_db --archive=$backup_path/$db_name-$date.gz --gzip

# Change permissions
chmod 0644 $backup_path/$db_name-$date.gz

# Delete files older than 30 days
find $backup_path/* -mtime +30 -exec rm {} \;