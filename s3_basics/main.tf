#terraform s3 - creating a bucket:
resource "aws_s3_bucket" "bucket" {
  bucket_prefix = var.bucket_prefix

  tags = {
    "Project" = "hands-on.cloud"
  }
}

#terraform s3 - creating an object:

resource "aws_s3_object" "object" {
  bucket = aws_s3_bucket.bucket.id
  key    = var.key_name
  source = var.source_path

  etag = filemd5(var.source_path)
}