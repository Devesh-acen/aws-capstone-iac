variable "aws_region" {
  default = "us-east-1"
}

variable "iam_user_name" {
  description = "IAM username to provision"
  type        = string
  default     = "capstone-s3-reader"
}

variable "s3_read_policy_arn" {
  description = "Policy ARN stored as a variable"
  type        = string
  default     = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}
