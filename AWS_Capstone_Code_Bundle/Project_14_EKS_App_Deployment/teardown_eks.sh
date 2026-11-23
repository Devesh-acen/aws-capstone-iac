#!/bin/bash
set -e
kubectl delete -f deployment.yaml || true
eksctl delete cluster --name capstone-eks --region us-east-1
