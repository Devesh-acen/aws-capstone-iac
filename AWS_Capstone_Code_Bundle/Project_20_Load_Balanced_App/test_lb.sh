#!/bin/bash
ALB_DNS=$1
if [ -z "$ALB_DNS" ]; then
  echo "Usage: bash test_lb.sh <ALB_DNS_NAME>"
  exit 1
fi
for i in {1..6}; do
  echo -n "Request $i: "
  curl -s "http://${ALB_DNS}"
done
