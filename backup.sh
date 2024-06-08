#!/bin/bash
SOURCE_DIR="C:\Users\vaishnavi\Desktop\Jaya_Vaishnavi_AWS_Devops.docx"
BUCKET_NAME="aws-backup-bucket-files"
TIMESTAMP=$(date +%Y%m%d%H%M%S)
BACKUP_NAME="backup-$TIMESTAMP.tar.gz"

# Create a compressed archive of the source directory
tar -czf /tmp/$BACKUP_NAME -C $SOURCE_DIR .

# Upload the backup to S3
aws s3 cp /tmp/$BACKUP_NAME s3://$BUCKET_NAME/$BACKUP_NAME

# Remove the local backup file
rm /tmp/$BACKUP_NAME
