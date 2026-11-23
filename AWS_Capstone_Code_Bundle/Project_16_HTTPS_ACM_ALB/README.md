# Project 16: Enable HTTPS using ACM
1. Obtain an ACM certificate ARN (or run `generate_self_signed.sh` to import a self-signed cert).
2. Run `terraform init && terraform apply -var="acm_certificate_arn=<YOUR_ARN>"`.
3. Register your web EC2 in `capstone-https-tg`, open `https://<alb_dns>`, and screenshot HTTPS working + HTTP blocked.
