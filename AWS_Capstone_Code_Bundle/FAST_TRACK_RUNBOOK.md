# Fast-Track Execution Order & Teardown Runbook

Follow these 6 phases in order to complete all 24 projects with minimal duplicate infrastructure and zero surprise AWS charges.

---

## Phase 1: Core Terraform + GitHub + CI/CD (Projects 1, 6, 7, 11, 12, 18)
*Reuse **one** public GitHub repository (`aws-capstone-iac`) and the Project 1 Terraform code across all Git/CI/CD projects.*

1. **Project 1 (EC2 Web Server):**
   - `cd Project_01_EC2_Web_Server_Terraform`
   - `terraform init && terraform apply -auto-approve`
   - Open `http://<web_public_ip>` → capture **webpage screenshot**.
2. **Project 6 (Version Control Infra):**
   - Push `Project_01` to your GitHub repo `main` branch (`Project_06_Version_Control_Infra/git_workflow.sh`).
   - Create branch `feat/update-ec2-tags`, edit a tag in `main.tf`, push, and open a Pull Request → save **PR link**.
3. **Project 7 (CI Validation):**
   - Copy `Project_07_CI_Validation_Terraform/.github/workflows/terraform-ci.yml` into your repo.
   - Add the workflow badge from `README_BADGE_SNIPPET.md` to `README.md`, run `terraform fmt -recursive`, and push to `main` → capture **pipeline screenshot**.
4. **Project 11 (Branching Policy):**
   - Enable Branch Protection on `main` (require PR + approval).
   - Run `Project_11_Branching_Policy_PR/branching_commands.sh`, open PR, review/approve, and merge → capture **PR screenshots**.
5. **Project 12 (CI Terraform Plan):**
   - Add `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` in GitHub Repo Secrets.
   - Copy `Project_12_CI_Terraform_Plan/.github/workflows/terraform-plan.yml` into `.github/workflows/` and push → capture **job success + uploaded artifact screenshot**.
6. **Project 18 (GitOps Infra Deployment):**
   - Create a GitHub Environment named `production` with Required Reviewers.
   - Copy `Project_18_GitOps_Infra_Deployment/.github/workflows/gitops-apply.yml` into `.github/workflows/`, merge a PR to `main`, approve the deployment gate → capture **workflow run screenshot**.

---

## Phase 2: S3 Storage, Lifecycle & IAM (Projects 2, 4, 19, 22, 23)
1. **Project 2 (S3 Static Website):**
   - `cd Project_02_S3_Static_Website_Terraform` → set a globally unique `bucket_name` in `variables.tf` → `terraform init && terraform apply -auto-approve`.
   - Open `http://<website_url>` → capture **website screenshot** + **repo link**.
2. **Project 4 (IAM User Automation):**
   - `cd Project_04_IAM_User_Automation` → `terraform init && terraform apply -auto-approve`.
   - Run `./test_iam.sh` → capture **test evidence screenshot** (`s3 ls` allowed, `ec2 describe-instances` denied) + **repo link**.
3. **Project 23 (IAM Role Based Access):**
   - `cd Project_23_IAM_Role_Based_Access` → `terraform init && terraform apply -auto-approve` (creates EC2 + IAM Role with S3 access, no hardcoded keys).
   - SSH into the EC2 and run `./verify_role.sh` → capture **CLI test output**.
4. **Project 19 (Scheduled S3 Backup):**
   - On the same EC2 from Project 23 (already has S3 IAM role!), copy `Project_19_Scheduled_S3_Backup/backup_logs.sh` & `install_cron.sh`, update `BUCKET_NAME`, and run `./install_cron.sh`.
   - Wait 5 minutes → capture **crontab + S3 bucket backup files screenshot**.
5. **Project 22 (S3 Log Archive with Lifecycle):**
   - `cd Project_22_S3_Log_Archive_Lifecycle` → point to your backup bucket (or deploy the new bucket) → `terraform init && terraform apply -auto-approve`.
   - Open S3 Console → Management → Lifecycle rules → capture **S3 rule screenshot**.

---

## Phase 3: Linux, Ansible, Monitoring & Chaos (Projects 3, 5, 15, 17, 21, 24)
*Reuse your Linux EC2 instances from Phase 1/2 to save time.*

1. **Project 5 (Secure Linux Permissions):**
   - On any Linux EC2, run `sudo bash Project_05_Linux_Server_Permissions/setup_permissions.sh` and `sudo bash test_permissions.sh` → capture **allowed/denied screenshots** (write-up is pre-filled in your `.docx`).
2. **Project 3 (CloudWatch CPU Alarm):**
   - `cd Project_03_EC2_CloudWatch_Alarm` → `terraform init && terraform apply -auto-approve`.
   - SSH in and run `bash stress_cpu.sh` for 2 minutes → capture **CloudWatch In Alarm screenshot** + **repo link**.
3. **Project 17 (Log Forwarding to CloudWatch):**
   - Attach `CloudWatchAgentServerPolicy` to your EC2 IAM role, copy `Project_17_CloudWatch_Log_Forwarding/*` to EC2, and run `sudo bash install_cw_agent.sh` → capture **CloudWatch Log Group screenshot**.
4. **Project 15 (Ansible Server Config):**
   - Update `Project_15_Ansible_Server_Config/inventory.ini` with a target Linux EC2 IP and `.pem` key, then run `ansible-playbook -i inventory.ini install_web.yml` → capture **playbook output + webpage screenshots**.
5. **Project 24 (Manual Chaos Test):**
   - On a running web server EC2, run `sudo bash Project_24_Manual_Chaos_Test/chaos_test.sh` and record the exact timestamps into the **Incident Notes** section of your `.docx`.
6. **Project 21 (CloudWatch Monitoring Dashboard):**
   - `cd Project_21_CloudWatch_Dashboard` → update `instance_id` in `dashboard.tf` → `terraform init && terraform apply -auto-approve` → capture **Dashboard screenshot**.

---

## Phase 4: Load Balancing & HTTPS (Projects 20, 16)
1. **Project 20 (Load Balanced App Deployment):**
   - `cd Project_20_Load_Balanced_App` → `terraform init && terraform apply -auto-approve`.
   - Run `./test_lb.sh <alb_dns_name>` and check Target Group health → capture **load balancing screenshot**.
2. **Project 16 (Enable HTTPS using ACM):**
   - Request a public ACM cert (if you own a domain) OR run `Project_16_HTTPS_ACM_ALB/generate_self_signed.sh` and import it into ACM.
   - Update `acm_certificate_arn` in `Project_16_HTTPS_ACM_ALB/main.tf` → `terraform apply` → capture **HTTPS screenshot** (showing HTTPS:443 working and HTTP:80 blocked).

---

## Phase 5: Containers & Kubernetes (Projects 8, 13, 14)
1. **Project 8 (Docker App Locally):**
   - `cd Project_08_Docker_App_Locally && bash run_local.sh` → open `http://localhost:8080` → capture **screenshot** (`docker ps` + browser).
2. **Project 13 (Build & Push to ECR):**
   - `cd Project_13_Build_Push_ECR && bash push_to_ecr.sh` → capture **ECR Console screenshot**.
3. **Project 14 (EKS Deployment):**
   - `cd Project_14_EKS_App_Deployment` → update `image:` in `deployment.yaml` with your ECR URI → `bash eks_deploy.sh` → open `http://<EXTERNAL-IP>` → capture **public access screenshot**.
   - **IMMEDIATELY TEAR DOWN EKS** after screenshots: `bash teardown_eks.sh` (EKS costs ~$0.10/hr + EC2 nodes).

---

## Phase 6: Windows Server AD DS & Internal DNS (Projects 9, 10)
1. **Project 9 (Domain Controller Setup):**
   - Launch a Windows Server 2022 EC2 (`t3.medium` recommended) with RDP (3389) open to your IP.
   - RDP in as Administrator → run `Project_09_Domain_Controller_Setup/01_install_adds.ps1` (reboots automatically).
   - Log back in as `CAPSTONE\Administrator` → run `02_create_domain_users.ps1`.
   - Log in as `CAPSTONE\user1` and `CAPSTONE\user2` → capture **login proof screenshots** (`whoami`).
2. **Project 10 (Internal DNS Setup):**
   - On the same Domain Controller, run `Project_10_Internal_DNS_Setup/add_dns_record.ps1` (sets A record `web.capstone.local`) → run `nslookup web.capstone.local` → capture **`nslookup` proof screenshot**.
   - *(Alternatively, deploy `route53_private_dns.tf` inside your AWS VPC.)*

---

## Final Teardown Checklist (Run After All Screenshots Are Saved!)
Run `terraform destroy -auto-approve` in every Terraform directory you applied:
- `Project_01_EC2_Web_Server_Terraform`
- `Project_02_S3_Static_Website_Terraform`
- `Project_03_EC2_CloudWatch_Alarm`
- `Project_04_IAM_User_Automation`
- `Project_16_HTTPS_ACM_ALB`
- `Project_20_Load_Balanced_App`
- `Project_21_CloudWatch_Dashboard`
- `Project_22_S3_Log_Archive_Lifecycle`
- `Project_23_IAM_Role_Based_Access`

Also manually verify in the AWS Console that:
- EKS cluster (`capstone-eks`) is deleted (`eksctl delete cluster --name capstone-eks --region us-east-1`).
- Windows Server EC2 instance is terminated.
- ECR repository (`capstone-app`) is deleted (`aws ecr delete-repository --repository-name capstone-app --force`).
- No stray Elastic IPs, ALBs, or NAT Gateways remain.
