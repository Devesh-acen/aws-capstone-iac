variable "aws_region" {
  default = "us-east-1"
}

variable "cpu_threshold" {
  description = "CPU percentage threshold for CloudWatch alarm"
  default     = 50
}
