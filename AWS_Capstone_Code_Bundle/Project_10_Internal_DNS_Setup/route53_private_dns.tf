# Alternative AWS-native Private DNS option using Route 53
variable "vpc_id" {
  description = "Existing VPC ID"
  type        = string
}

variable "web_server_private_ip" {
  description = "Private IP of your EC2 web server"
  type        = string
}

resource "aws_route53_zone" "internal" {
  name = "capstone.internal"
  vpc {
    vpc_id = var.vpc_id
  }
}

resource "aws_route53_record" "web_a" {
  zone_id = aws_route53_zone.internal.zone_id
  name    = "web.capstone.internal"
  type    = "A"
  ttl     = 300
  records = [var.web_server_private_ip]
}
