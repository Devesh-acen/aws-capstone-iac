#!/bin/bash
echo "=== 1. Confirm no static AWS credentials file exists ==="
ls -la ~/.aws/credentials 2>&1 || true

echo ""
echo "=== 2. Verify Assumed IAM Role Identity ==="
aws sts get-caller-identity

echo ""
echo "=== 3. Verify S3 Access via Instance Profile ==="
aws s3 ls
