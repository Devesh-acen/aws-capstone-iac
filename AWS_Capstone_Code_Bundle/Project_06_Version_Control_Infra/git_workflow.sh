#!/bin/bash
# Usage: bash git_workflow.sh https://github.com/<your-username>/<your-repo>.git
REPO_URL=$1
if [ -z "$REPO_URL" ]; then
  echo "Usage: bash git_workflow.sh <GITHUB_REPO_URL>"
  exit 1
fi

git init
git add .
git commit -m "Initial Terraform infrastructure commit"
git branch -M main
git remote add origin "$REPO_URL"
git push -u origin main

git checkout -b feat/update-ec2-tags
echo "# Updated for Project 6 Pull Request" >> README.md
git add README.md
git commit -m "Update documentation and infra tags via feature branch"
git push -u origin feat/update-ec2-tags

echo "Now open $REPO_URL in your browser and raise a Pull Request from feat/update-ec2-tags -> main."
