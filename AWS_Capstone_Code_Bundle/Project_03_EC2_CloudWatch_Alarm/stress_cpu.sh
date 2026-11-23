#!/bin/bash
# Run on the EC2 instance (via SSH or EC2 Instance Connect) for ~2 minutes
echo "Starting CPU stress test for 150 seconds..."
yes > /dev/null &
PID1=$!
yes > /dev/null &
PID2=$!
sleep 150
kill $PID1 $PID2
echo "CPU stress test completed."
