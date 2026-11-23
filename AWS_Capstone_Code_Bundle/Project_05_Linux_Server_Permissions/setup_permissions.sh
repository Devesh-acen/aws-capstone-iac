#!/bin/bash
set -e
# Run with sudo on a Linux server
groupadd -f devteam
groupadd -f auditgroup

id -u alice &>/dev/null || useradd -m -G devteam alice
id -u bob &>/dev/null || useradd -m -G auditgroup bob

mkdir -p /opt/secure_app
echo "CONFIDENTIAL_DB_HOST=internal.capstone.local" > /opt/secure_app/config.txt

chown root:devteam /opt/secure_app
chown root:devteam /opt/secure_app/config.txt
chmod 750 /opt/secure_app
chmod 640 /opt/secure_app/config.txt

echo "Setup complete. Directory and file permissions:"
ls -ld /opt/secure_app
ls -l /opt/secure_app/config.txt
