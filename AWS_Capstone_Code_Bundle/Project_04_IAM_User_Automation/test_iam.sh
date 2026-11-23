#!/bin/bash
set -e
KEY_ID=$(terraform output -raw access_key_id)
SECRET=$(terraform output -raw secret_access_key)

echo "=== Testing S3 Read Access (Expected: SUCCESS) ==="
AWS_ACCESS_KEY_ID="$KEY_ID" AWS_SECRET_ACCESS_KEY="$SECRET" AWS_DEFAULT_REGION="us-east-1" aws s3 ls

echo ""
echo "=== Testing EC2 Describe Access (Expected: AccessDenied / UnauthorizedOperation) ==="
AWS_ACCESS_KEY_ID="$KEY_ID" AWS_SECRET_ACCESS_KEY="$SECRET" AWS_DEFAULT_REGION="us-east-1" aws ec2 describe-instances || true
