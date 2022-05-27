#create S3 Bucket to act as backend
resource "aws_s3_bucket" "backend_bucket" {
  bucket = var.bucket_name

  tags = {
    "Project" = "hands-on.cloud"
  }
}

