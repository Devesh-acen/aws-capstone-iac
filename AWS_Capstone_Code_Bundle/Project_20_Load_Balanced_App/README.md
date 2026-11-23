# Project 20: Load Balanced App Deployment
1. `terraform init && terraform apply -auto-approve`
2. Wait ~2 minutes for both EC2 targets to pass ALB health checks.
3. Run `bash test_lb.sh <alb_dns_name>` and screenshot alternating responses + Healthy targets in AWS Console.
