provider "aws" {
  region = "ap-south-1"
}

resource "aws_s3_bucket" "backup" {
  bucket = "prod-backup"

  tags = {
    Name        = "prod-backup"
    Environment = "Production"
  }
}

resource "aws_s3_bucket_versioning" "backup_versioning" {
  bucket = aws_s3_bucket.backup.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "backup_encryption" {
  bucket = aws_s3_bucket.backup.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

output "s3_bucket_name" {
  value = aws_s3_bucket.backup.bucket
}
