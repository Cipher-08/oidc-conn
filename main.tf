provider "aws" {
  region = "ap-south-1" 
}

resource "aws_s3_bucket" "prod_backup" {
  bucket = "prod-backup-2025" 

  tags = {
    Name        = "prod-backup-2025"
    Environment = "Production environment"
  }
}

resource "aws_s3_bucket_versioning" "prod_backup_versioning" {
  bucket = aws_s3_bucket.prod_backup.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "prod_backup_encryption" {
  bucket = aws_s3_bucket.prod_backup.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

output "s3_bucket_name" {
  value = aws_s3_bucket.prod_backup.bucket
}
