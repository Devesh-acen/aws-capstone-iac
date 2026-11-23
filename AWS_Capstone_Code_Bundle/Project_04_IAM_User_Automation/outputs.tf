output "iam_user_name" {
  value = aws_iam_user.reader.name
}

output "access_key_id" {
  value = aws_iam_access_key.reader_key.id
}

output "secret_access_key" {
  value     = aws_iam_access_key.reader_key.secret
  sensitive = true
}
