provider "aws" {
  region = var.aws_region
}

resource "aws_iam_user" "reader" {
  name = var.iam_user_name
  tags = { Project = "Capstone-P4" }
}

resource "aws_iam_user_policy_attachment" "s3_read_attach" {
  user       = aws_iam_user.reader.name
  policy_arn = var.s3_read_policy_arn
}

resource "aws_iam_access_key" "reader_key" {
  user = aws_iam_user.reader.name
}
