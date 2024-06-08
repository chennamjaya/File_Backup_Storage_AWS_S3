#!/bin/bash

# Define the directory to back up
SOURCE_DIR="/mnt/c/Users/vaishnavi/Desktop"

# Define the specific file to back up
FILE_NAME="Jaya_Vaishnavi_AWS_Devops.docx"

# Define the S3 bucket name
BUCKET_NAME="aws-backup-bucket-files"

# Determine the MIME type based on the file extension
EXTENSION="${FILE_NAME##*.}"
case "$EXTENSION" in
    txt)
        MIME_TYPE="text/plain"
        ;;
    docx)
        MIME_TYPE="application/vnd.openxmlformats-officedocument.wordprocessingml.document"
        ;;
    pdf)
        MIME_TYPE="application/pdf"
        ;;
    jpg|jpeg)
        MIME_TYPE="image/jpeg"
        ;;
    png)
        MIME_TYPE="image/png"
        ;;
    *)
        MIME_TYPE="application/octet-stream"
        ;;
esac

# Generate a timestamp
TIMESTAMP=$(date +%Y%m%d%H%M%S)

# Define the backup file name with timestamp
BACKUP_NAME="$TIMESTAMP-$FILE_NAME"

# Upload the file to S3 with the correct MIME type
aws s3 cp "$SOURCE_DIR/$FILE_NAME" s3://$BUCKET_NAME/$BACKUP_NAME --content-type "$MIME_TYPE"

# Print the URL of the uploaded file
echo "File uploaded to: https://$BUCKET_NAME.s3.amazonaws.com/$BACKUP_NAME"

# Make the uploaded file public
aws s3api put-object-acl --bucket $BUCKET_NAME --key "$BACKUP_NAME" --acl public-read
