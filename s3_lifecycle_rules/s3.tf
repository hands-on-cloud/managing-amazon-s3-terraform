resource "aws_s3_bucket" "bucket" {
  bucket_prefix = var.bucket_prefix
}

# lifecycle rule:
resource "aws_s3_bucket_lifecycle_configuration" "lifecycle_config" {
  bucket = aws_s3_bucket.bucket.id

  rule {
    id = "rule1"
    status = "Enabled"

    #filter to get objects with the required tags:
    filter {
      tag {
        key = "lifecycle_enabled"
        value = "true"
      }
    }

    #transition to STANDARD_IA after 30 days:
    transition {
      storage_class = "STANDARD_IA"
      days = 30
    }

    #transition to GLACIER after 90 days:
    transition {
      storage_class = "GLACIER"
      days = 90
    }

    #transition to DEEP_ARCHIVE after 180 days:
    transition {
      storage_class = "DEEP_ARCHIVE"
      days = 180
    }

    #delete after 1 year:
    expiration {
      days = 365
    }

  }
}