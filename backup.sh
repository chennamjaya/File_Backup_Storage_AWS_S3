#!/bin/bash

# Define the directory to back up
SOURCE_DIR="/mnt/c/Users/vaishnavi/Desktop"  # Use the directory containing the file

# Define the specific file to back up
FILE_NAME="Jaya_Vaishnavi_AWS_Devops.docx"

# Define the S3 bucket name
BUCKET_NAME="aws-backup-bucket-files"

# Generate a timestamp
TIMESTAMP=$(date +%Y%m%d%H%M%S)

# Define the backup file name
BACKUP_NAME="backup-$TIMESTAMP.tar.gz"

# Create a compressed archive of the specific file
tar -czf /tmp/$BACKUP_NAME -C $SOURCE_DIR $FILE_NAME

# Upload the backup to S3
aws s3 cp /tmp/$BACKUP_NAME s3://$BUCKET_NAME/$BACKUP_NAME

# Remove the local backup file
rm /tmp/$BACKUP_NAME
