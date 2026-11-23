#!/bin/bash
set -e
# Run inside your GitHub Terraform repository after enabling branch protection on 'main'
git checkout main
git pull origin main
git checkout -b feature/branch-policy-update
echo "# Verified branching strategy and PR review policy" >> README.md
git add README.md
git commit -m "feat: apply infrastructure change via protected feature branch"
git push -u origin feature/branch-policy-update
echo "Open GitHub, create a PR into main, complete review, merge, and capture PR screenshots."
