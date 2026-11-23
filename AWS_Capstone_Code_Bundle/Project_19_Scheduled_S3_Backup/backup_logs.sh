#!/bin/bash
set -e
BUCKET_NAME="capstone-log-backups-change-me-12345"
TIMESTAMP=$(date +%Y%m%d-%H%M%S)
ARCHIVE="/tmp/ec2-logs-${TIMESTAMP}.tar.gz"

if [ -d /var/log/httpd ]; then
  tar -czf "$ARCHIVE" /var/log/httpd
else
  tar -czf "$ARCHIVE" /var/log/messages
fi

aws s3 cp "$ARCHIVE" "s3://${BUCKET_NAME}/logs/ec2-logs-${TIMESTAMP}.tar.gz"
rm -f "$ARCHIVE"
echo "[${TIMESTAMP}] Uploaded backup to s3://${BUCKET_NAME}/logs/"
