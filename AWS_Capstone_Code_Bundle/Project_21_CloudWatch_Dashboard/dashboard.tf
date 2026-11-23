variable "aws_region" { default = "us-east-1" }
variable "instance_id" {
  description = "EC2 Instance ID to monitor on the dashboard"
  type        = string
}

provider "aws" {
  region = var.aws_region
}

resource "aws_cloudwatch_dashboard" "main" {
  dashboard_name = "Capstone-Infra-Dashboard"

  dashboard_body = jsonencode({
    widgets = [
      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 12
        height = 6
        properties = {
          metrics = [
            ["AWS/EC2", "CPUUtilization", "InstanceId", var.instance_id]
          ]
          period = 60
          stat   = "Average"
          region = var.aws_region
          title  = "EC2 CPU Utilization (%)"
        }
      },
      {
        type   = "metric"
        x      = 12
        y      = 0
        width  = 12
        height = 6
        properties = {
          metrics = [
            ["AWS/EC2", "NetworkIn", "InstanceId", var.instance_id],
            [".", "NetworkOut", ".", "."]
          ]
          period = 60
          stat   = "Sum"
          region = var.aws_region
          title  = "EC2 Network In / Out (Bytes)"
        }
      }
    ]
  })
}
