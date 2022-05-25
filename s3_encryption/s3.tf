#terraform s3 - SSE-S3 bucket encryption:
resource "aws_s3_bucket" "sse_s3_bucket" {
  bucket_prefix = "${var.bucket_prefix}sse-s3"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "sse_config" {
  bucket = aws_s3_bucket.sse_s3_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "AES256"
    }
  }
}

resource "aws_s3_object" "sse_s3_object" {
  bucket = aws_s3_bucket.sse_s3_bucket.id

  key    = basename(var.upload_source)
  source = var.upload_source
  etag   = filemd5(var.upload_source)

  server_side_encryption = "AES256"

  depends_on = [
    aws_s3_bucket.sse_s3_bucket
  ]
}

#terraform s3 - SSE-KMS bucket encryption:
resource "aws_s3_bucket" "sse_kms_bucket" {
  bucket_prefix = "${var.bucket_prefix}sse-kms"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "sse_kms_config" {
  bucket = aws_s3_bucket.sse_kms_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.key.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_s3_object" "sse_kms_object" {
  bucket = aws_s3_bucket.sse_kms_bucket.id

  key    = basename(var.upload_source)
  source = var.upload_source
  etag   = filemd5(var.upload_source)

  server_side_encryption = "aws:kms"

  depends_on = [
    aws_s3_bucket.sse_kms_bucket
  ]
}
