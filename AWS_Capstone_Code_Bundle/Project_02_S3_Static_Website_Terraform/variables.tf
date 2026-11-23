variable "aws_region" {
  default = "us-east-1"
}

variable "bucket_name" {
  description = "MUST be globally unique across all AWS accounts"
  default     = "capstone-static-site-change-me-12345"
}
