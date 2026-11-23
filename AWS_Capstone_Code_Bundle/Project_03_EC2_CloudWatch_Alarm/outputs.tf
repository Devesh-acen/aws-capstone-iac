output "instance_id" {
  value = aws_instance.monitored_ec2.id
}

output "alarm_name" {
  value = aws_cloudwatch_metric_alarm.cpu_high.alarm_name
}
