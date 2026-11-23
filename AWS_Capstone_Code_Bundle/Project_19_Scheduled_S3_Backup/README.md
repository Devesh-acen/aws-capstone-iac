# Project 19: Scheduled S3 Backup
1. Replace `BUCKET_NAME` in `backup_logs.sh` with your S3 bucket name.
2. Run `bash install_cron.sh` on an EC2 with an S3-write IAM role.
3. Screenshot `crontab -l` and the `.tar.gz` backup files in the S3 Console.
