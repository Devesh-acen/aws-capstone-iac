variable "aws_region" { default = "us-east-1" }
variable "bucket_name" {
  description = "Globally unique bucket name for log archiving"
  default     = "capstone-log-archive-change-me-12345"
}

provider "aws" {
  region = var.aws_region
}

resource "aws_s3_bucket" "log_archive" {
  bucket        = var.bucket_name
  force_destroy = true
}

resource "aws_s3_object" "sample_log" {
  bucket  = aws_s3_bucket.log_archive.id
  key     = "logs/sample-app.log"
  content = "2026-11-19 INFO Capstone sample log archived in S3."
}

resource "aws_s3_bucket_lifecycle_configuration" "log_lifecycle" {
  bucket = aws_s3_bucket.log_archive.id

  rule {
    id     = "archive-and-expire-logs"
    status = "Enabled"

    filter {
      prefix = "logs/"
    }

    transition {
      days          = 30
      storage_class = "GLACIER"
    }

    expiration {
      days = 90
    }
  }
}
