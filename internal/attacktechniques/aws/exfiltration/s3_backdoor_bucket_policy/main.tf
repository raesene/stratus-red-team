terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.71.0"
    }
  }
}
provider "aws" {
  skip_region_validation      = true
  skip_credentials_validation = true
  skip_get_ec2_platforms      = true
  skip_metadata_api_check     = true
}

resource "random_string" "suffix" {
  length    = 16
  min_lower = 16
  special   = false
}

resource "aws_s3_bucket" "bucket" {
  bucket = "stratus-red-team-${random_string.suffix.result}"
  acl    = "private"

  tags = {
    StratusRedTeam = true
  }
}

output "bucket_name" {
  value = aws_s3_bucket.bucket.id
}

output "display" {
  value = format("S3 bucket: %s", aws_s3_bucket.bucket.id)
}