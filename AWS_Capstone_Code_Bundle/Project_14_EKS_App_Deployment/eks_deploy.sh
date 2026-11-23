#!/bin/bash
set -e
REGION="us-east-1"
CLUSTER_NAME="capstone-eks"

eksctl create cluster   --name "$CLUSTER_NAME"   --region "$REGION"   --nodegroup-name standard-nodes   --node-type t3.small   --nodes 2

kubectl apply -f deployment.yaml
echo "Waiting 45s for LoadBalancer EXTERNAL-IP..."
sleep 45
kubectl get pods,svc
