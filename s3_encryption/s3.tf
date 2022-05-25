#terraform s3 - create bucket
resource "aws_s3_bucket" "bucket" {
  bucket_prefix = var.bucket_prefix
}

#terraform s3 - SSE configuration
resource "aws_s3_bucket_server_side_encryption_configuration" "sse_config" {
  bucket = aws_s3_bucket.bucket.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "AES256"
    }
  }
}

#terraform s3 - upload object
resource "aws_s3_object" "object" {
  bucket = aws_s3_bucket.bucket.id

  key    = basename(var.upload_source)
  source = var.upload_source
  etag   = filemd5(var.upload_source)

  depends_on = [
    aws_s3_bucket.bucket
  ]
}