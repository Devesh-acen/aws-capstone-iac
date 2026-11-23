output "web_public_ip" {
  description = "Public IP of the EC2 web server"
  value       = aws_instance.web.public_ip
}

output "web_url" {
  description = "HTTP URL to test the web server"
  value       = "http://${aws_instance.web.public_ip}"
}
