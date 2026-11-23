# Project 10: Internal DNS Setup
- **Windows DNS (fastest):** Run `add_dns_record.ps1 -WebServerIP <EC2_IP>` on the Project 9 DC and capture the `nslookup web.capstone.local` screenshot.
- **AWS Route 53 (alternative):** Apply `route53_private_dns.tf` and run `nslookup web.capstone.internal` from an EC2 inside the VPC.
