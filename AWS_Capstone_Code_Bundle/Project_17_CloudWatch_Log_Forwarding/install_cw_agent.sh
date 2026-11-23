#!/bin/bash
set -e
# Prerequisite: Attach an IAM Role with CloudWatchAgentServerPolicy to this EC2 instance
dnf install -y amazon-cloudwatch-agent || yum install -y amazon-cloudwatch-agent
cp amazon-cloudwatch-agent.json /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json
/opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl   -a fetch-config -m ec2   -c file:/opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json -s
logger "Capstone Project 17 test log event sent to CloudWatch"
echo "CloudWatch Agent started. Check Log Group /capstone/ec2/system-logs in AWS Console."
