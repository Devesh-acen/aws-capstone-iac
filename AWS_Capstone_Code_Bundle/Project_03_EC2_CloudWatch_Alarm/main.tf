provider "aws" {
  region = var.aws_region
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["al2023-ami-2023*-x86_64"]
  }
}

resource "aws_instance" "monitored_ec2" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"
  tags          = { Name = "capstone-cw-monitored-ec2" }
}

resource "aws_cloudwatch_metric_alarm" "cpu_high" {
  alarm_name          = "capstone-ec2-high-cpu-alarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Average"
  threshold           = var.cpu_threshold
  alarm_description   = "Triggers when EC2 CPU exceeds threshold"

  dimensions = {
    InstanceId = aws_instance.monitored_ec2.id
  }
}
