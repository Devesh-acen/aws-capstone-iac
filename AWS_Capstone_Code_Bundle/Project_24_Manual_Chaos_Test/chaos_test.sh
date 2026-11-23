#!/bin/bash
# Run with sudo on your Apache (httpd) EC2 web server
SERVICE="httpd"

echo "=== [$(date -u '+%Y-%m-%d %H:%M:%S UTC')] STEP 1: BASELINE CHECK ==="
systemctl is-active "$SERVICE"
curl -I -s http://localhost | head -n 1

echo ""
echo "=== [$(date -u '+%Y-%m-%d %H:%M:%S UTC')] STEP 2: INJECT FAILURE (STOP SERVICE) ==="
systemctl stop "$SERVICE"
systemctl is-active "$SERVICE" || true
curl -I -s http://localhost || echo "Expected Failure: Connection refused"

echo ""
echo "Simulating outage window (10 seconds)..."
sleep 10

echo ""
echo "=== [$(date -u '+%Y-%m-%d %H:%M:%S UTC')] STEP 3: RESTART & VERIFY RECOVERY ==="
systemctl start "$SERVICE"
systemctl is-active "$SERVICE"
curl -I -s http://localhost | head -n 1
echo "=== [$(date -u '+%Y-%m-%d %H:%M:%S UTC')] RECOVERY COMPLETE ==="
