# File_Backup_Storage_AWS_S3
In this project, I set up an automatic file backup utilizing the Amazon S3 service and a simple bash script to conduct the backup process. 
Prerequisites: Create an S3 bucket in an Amazon account, use vs code to modify code, and build a project repository with a GitHub account.

This project aims to build up an automated backup system utilizing Amazon S3 to safeguard and maintain the availability of files saved on your local machine or server. Here's why you might take on this project. 
1. Backup your files to Amazon S3 to prevent accidental deletion, corruption, or hardware failure on your local machine or server. S3 backups are durable, redundant, and scalable.
2. Backups stored on S3 enable speedy recovery from server crashes, ransomware attacks, and natural disasters, minimizing downtime and restoring normal operations.
3. Cost-Effective Storage: Amazon S3 provides affordable storage alternatives where you only pay for the storage and bandwidth you require. This may be less expensive than traditional backup solutions or the maintenance of additional backup storage hardware. 
4. Automation: Automating backups lowers human error and assures consistent, scheduled backups. This allows you to devote more time and resources to other things. 
5. Scalability: Amazon S3 can readily scale to meet growing data storage needs without requiring significant changes to your backup systems. 
Overall, implementing an automatic backup system using Amazon S3 provides peace of mind knowing that your critical data is securely backed up and readily accessible when needed, helping to safeguard your business or personal information against loss or disruption.
Step 1: Create a new repository in GitHub called File_Backup_Storage_AWS_S3 
Use the git clone [repo URL] command to clone the repository URL to vscode. 
Step 2: Log in to your Amazon AWS account and access Amazon S3 service. 
Click on Create a new bucket, for example, aws-backup-bucket-files. 
Step 3: Create AWS credentials and configuration files. 
1. Create an AWS Credentials file. 
To create a file, open VSCode and navigate to ~/.aws/credentials (Linux/macOS) or C:\Users\YourUsername\.aws\credentials (Windows). 
Add your AWS credentials.
[default]
aws_access_key_id = YOUR_ACCESS_KEY_ID
aws_secret_access_key = YOUR_SECRET_ACCESS_KEY
2. Create an AWS configuration file in the same directory, such as ~/.aws/config for Linux/macOS or C:\Users\YourUsername\.aws\config for Windows. 
Add your default region:
[default]
region = YOUR_DEFAULT_REGION
Step 4: Write the Backup Script. 
1. Create a new script file. 
Create a backup.sh or backup.txt file in your repository directory using VSCode.PS1 (for Windows). 
2. Write the backup script:
o	For Linux/macOS (backup.sh):
o	#!/bin/bash
o	
o	# Define the directory to back up
o	SOURCE_DIR="/mnt/c/Users/vaishnavi/Desktop"
o	
o	# Define the specific file to back up
o	FILE_NAME="Jaya_Vaishnavi_AWS_Devops.docx"
o	
o	# Define the S3 bucket name
o	BUCKET_NAME="aws-backup-bucket-files"
o	
o	# Determine the MIME type based on the file extension
o	EXTENSION="${FILE_NAME##*.}"
o	case "$EXTENSION" in
o	    txt)
o	        MIME_TYPE="text/plain"
o	        ;;
o	    docx)
o	        MIME_TYPE="application/vnd.openxmlformats-officedocument.wordprocessingml.document"
o	        ;;
o	    pdf)
o	        MIME_TYPE="application/pdf"
o	        ;;
o	    jpg|jpeg)
o	        MIME_TYPE="image/jpeg"
o	        ;;
o	    png)
o	        MIME_TYPE="image/png"
o	        ;;
o	    *)
o	        MIME_TYPE="application/octet-stream"
o	        ;;
o	esac
o	
o	# Generate a timestamp
o	TIMESTAMP=$(date +%Y%m%d%H%M%S)
o	
o	# Define the backup file name with timestamp
o	BACKUP_NAME="$TIMESTAMP-$FILE_NAME"
o	
o	# Upload the file to S3 with the correct MIME type
o	aws s3 cp "$SOURCE_DIR/$FILE_NAME" s3://$BUCKET_NAME/$BACKUP_NAME --content-type "$MIME_TYPE"
o	
o	# Print the URL of the uploaded file
echo "File uploaded to: https://$BUCKET_NAME.s3.amazonaws.com/$BACKUP_NAME"
The script uploads the file with the appropriate MIME type but does not set the ACL.


o	For Windows (backup.ps1):
powershell
Copy code
$sourceDir = "C:\path\to\your\files"
$bucketName = "my-backup-bucket"
$timestamp = Get-Date -Format "yyyyMMddHHmmss"
$backupName = "backup-$timestamp.zip"
$backupPath = "C:\temp\$backupName"

# Create a compressed archive of the source directory
Compress-Archive -Path $sourceDir -DestinationPath $backupPath

# Upload the backup to S3
aws s3 cp $backupPath "s3://$bucketName/$backupName"

# Remove the local backup file
Remove-Item $backupPath
Step 5: Commit and push to GitHub. 
1. To stage your changes, open the source control window in VS Code. Git add
To stage your new script file, click the "+" symbol next to the file name. 
2. Commit your changes. Git commit -m “”
Type a commit message (e.g., "Add backup script"). 
Click the checkbox to commit your changes. 
3. To push your changes to GitHub, click the "..." symbol in the source control panel and select "Push". Git push origin
4. To permit the files you can use the command chmod +x /path/to/file
Step 6: Update the S3 Bucket Policy. 
To make the files publicly accessible, change the S3 bucket's policy to allow public read access. The bucket policy grants public read access to all objects in the bucket. This means that anyone can access the files through a browser using the specified URL.
Here's how you can accomplish it: 
1. Sign in to the AWS Management Console. 
2. Navigate to S3 service. 
3. Select the bucket (aws-backup-bucket-files). 
4. Navigate to the "Permissions" tab. 
5. In "Bucket policy," click "Edit" and add a policy like this: 
6.Save the policy.

json
Copy code
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::aws-backup-bucket-files/*"
        }
    ]
}


Manually test the script by running ./backup.sh 
Set up a cron job
A cron job runs your script at predetermined intervals. Follow these steps to set up a cron job:
1. Open the Crontab file and run crontab -e.
2. Create a Cron Job Entry. 
Add the following line to schedule the backup script to run at a set interval. For example, to run the script daily at 2:00 AM, you can include:
0 2 * * * /mnt/c/Users/vaishnavi/my-website/File_Backup_Storage_AWS_S3/backup.sh
This cron phrase signifies: 
0: Minute (0) 
2. Hour (2 AM) 
*: Day of the month (every day). 
*: Month (per month) 
*: Any day of the week.

Cron syntax consists of five fields, each representing a particular time unit. 
• 0 2 * * * denotes "At 2:00 AM every day." 
Step 3: Save and exit. 
Save your changes and quit the editor. To use vim, press Esc, then type:wq and press Enter. 
Step 4: Verify the Cron Job. 
List your cron jobs to ensure that your new job was added: 
crontab -l
Your cron job should be mentioned. 
Step 5: Monitor the Cron Job. 
Check the output and logs to check that the cron task is executing properly. To debug your script, you can route its output to a log file: 
1. Update the Crontab entry: 
Redirect the output to a log file to record any mistakes or outputs: 
0 2 * * * /mnt/c/Users/vaishnavi/my-website/File_Backup_Storage_AWS_S3/backup.sh >> /mnt/c/Users/vaishnavi/my-website/File_Backup_Storage_AWS_S3/backup.log 2>&1

2. Examine the Log File: After the cron job is completed, review the log file for any issues. 
cat /mnt/c/Users/vaishnavi/my-website/File_Backup_Storage_AWS_S3/backup.log
Automating with Windows 
If you're running Windows and utilizing WSL, the procedures above will work. If you do not wish to use WSL, you can use Task Scheduler: 
1. Launch Task Scheduler from the Start menu. 
2. Create a Basic Task: o Click "Create Basic Task." o Follow the wizard to enter a name, description, trigger (daily, weekly, etc.), and action (start a program). 
3. Set the program/script to run. 
- Program/script: bash.exe. 
Add the following arguments: -c "/path/to/file". 
4. Finish and Save: Task Scheduler will run your script at the desired interval.

Conclusion 
Setting up a cron job (or Task Scheduler on Windows) automates the backup process so that it runs at regular intervals, guaranteeing that your data are automatically backed up to S3. Check the log files for any difficulties and change the script or cron job as needed.




