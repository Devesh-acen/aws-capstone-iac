#!/bin/bash
set -e
REGION="us-east-1"
REPO_NAME="capstone-app"
IMAGE_TAG="v1"

ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
ECR_URI="${ACCOUNT_ID}.dkr.ecr.${REGION}.amazonaws.com/${REPO_NAME}"

aws ecr describe-repositories --repository-names "$REPO_NAME" --region "$REGION" >/dev/null 2>&1 ||   aws ecr create-repository --repository-name "$REPO_NAME" --region "$REGION"

aws ecr get-login-password --region "$REGION" |   docker login --username AWS --password-stdin "${ACCOUNT_ID}.dkr.ecr.${REGION}.amazonaws.com"

docker build -t "${REPO_NAME}:${IMAGE_TAG}" ../Project_08_Docker_App_Locally
docker tag "${REPO_NAME}:${IMAGE_TAG}" "${ECR_URI}:${IMAGE_TAG}"
docker push "${ECR_URI}:${IMAGE_TAG}"

echo "Pushed image successfully: ${ECR_URI}:${IMAGE_TAG}"
