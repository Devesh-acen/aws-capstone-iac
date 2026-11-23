#!/bin/bash
set -e
sudo cp backup_logs.sh /usr/local/bin/backup_logs.sh
sudo chmod +x /usr/local/bin/backup_logs.sh

# Schedule every 5 minutes for testing (change to '0 2 * * *' for daily 2 AM)
(crontab -l 2>/dev/null | grep -v backup_logs.sh; echo "*/5 * * * * /usr/local/bin/backup_logs.sh >> /var/log/s3_backup.log 2>&1") | crontab -

echo "Installed cron job:"
crontab -l
echo "Running one immediate backup test..."
/usr/local/bin/backup_logs.sh
