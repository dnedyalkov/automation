#!/bin/bash
# Database credentials
user="root"
password=""
host="127.0.0.1"
db_name="test"

# Other options
backup_path="/backups"
date=$(date +"%Y-%b-%d")

# Set default file permissions
umask 177

# Dump database into SQL file
mysqldump --user=$user --password=$password --host=$host $db_name > $backup_path/$db_name-$date.sql

# Compress SQL file
gzip $backup_path/$db_name-$date.sql

# Change permissions
chmod 0644 $backup_path/$db_name-$date.sql.gz

# Delete files older than 30 days
find $backup_path/* -mtime +30 -exec rm {} \;