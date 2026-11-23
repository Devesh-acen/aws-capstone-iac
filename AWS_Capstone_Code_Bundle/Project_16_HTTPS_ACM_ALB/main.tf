variable "aws_region" { default = "us-east-1" }
variable "acm_certificate_arn" {
  description = "ARN of your ACM certificate"
  type        = string
}

provider "aws" {
  region = var.aws_region
}

data "aws_vpc" "default" { default = true }
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

resource "aws_security_group" "alb_https_only_sg" {
  name        = "capstone-alb-https-only-sg"
  description = "Allow HTTPS 443 ONLY; block HTTP 80"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "HTTPS Only"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_lb" "https_alb" {
  name               = "capstone-https-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_https_only_sg.id]
  subnets            = slice(data.aws_subnets.default.ids, 0, 2)
}

resource "aws_lb_target_group" "https_tg" {
  name     = "capstone-https-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.default.id
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.https_alb.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  certificate_arn   = var.acm_certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.https_tg.arn
  }
}

# Explicit HTTP listener returning 403 Forbidden (in addition to SG blocking port 80)
resource "aws_lb_listener" "block_http" {
  load_balancer_arn = aws_lb.https_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "HTTP is blocked. Use HTTPS."
      status_code  = "403"
    }
  }
}

output "alb_https_url" {
  value = "https://${aws_lb.https_alb.dns_name}"
}
