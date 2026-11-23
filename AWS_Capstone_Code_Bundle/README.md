# AWS Cloud Infrastructure Automation — 24-Project Capstone Code Bundle

This bundle contains ready-to-run Infrastructure as Code (Terraform), CI/CD workflows (GitHub Actions), container manifests (Docker & Kubernetes), configuration management (Ansible), monitoring configs (CloudWatch), and automation scripts (Bash & PowerShell) for **Projects 1 through 24**.

## Prerequisites
- **AWS CLI v2** configured (`aws configure`) with an IAM user having admin/lab permissions
- **Terraform** >= 1.5
- **Git** & a **GitHub** account (keep capstone repos **public** so evaluators can verify links)
- **Docker Desktop / Docker Engine** (for Projects 8 & 13)
- **kubectl** & **eksctl** (for Project 14)
- **Ansible** (for Project 15 — can be installed on a Linux EC2 controller or WSL)
- **RDP Client** (for Windows Server AD DS / DNS in Projects 9 & 10)

## Where to Start
Open **`FAST_TRACK_RUNBOOK.md`** first. It groups all 24 projects into 6 efficient phases so you reuse the same VPC, EC2 instances, S3 bucket, ALB, Windows Domain Controller, and GitHub repository—cutting execution time and AWS costs dramatically.
