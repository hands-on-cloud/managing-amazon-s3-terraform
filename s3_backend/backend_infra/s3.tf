#create S3 Bucket to act as backend
resource "aws_s3_bucket" "backend_bucket" {
  bucket_prefix = var.bucket_prefix

  tags = {
    "Project" = "hands-on.cloud"
  }
}

