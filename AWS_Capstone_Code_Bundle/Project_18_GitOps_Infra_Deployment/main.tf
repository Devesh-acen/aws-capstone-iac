provider "aws" {
  region = "ap-southeast-2"
}
 
resource "aws_vpc" "gitops_vpc" {
  cidr_block = "10.99.0.0/16"
  tags = {
    Name      = "capstone-gitops-vpc"
    ManagedBy = "GitHub-Actions-GitOps"
  }
}
