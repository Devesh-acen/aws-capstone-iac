#!/bin/bash
# Use this ONLY if you do not own a public domain for DNS-validated ACM cert
openssl req -x509 -newkey rsa:2048 -keyout key.pem -out cert.pem -days 365 -nodes -subj "/CN=capstone.local"
aws acm import-certificate   --certificate fileb://cert.pem   --private-key fileb://key.pem   --region us-east-1
echo "Copy the returned CertificateArn into variables/main.tf!"
