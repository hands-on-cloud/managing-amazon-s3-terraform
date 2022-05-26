#create S3 bucket:
resource "aws_s3_bucket" "bucket" {
  bucket_prefix = var.bucket_prefix
}

#create S3 Event Notification:
resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.bucket.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.func.arn
    events              = ["s3:ObjectCreated:*"]
    filter_prefix       = "test"
    filter_suffix       = ".json"
  }

  depends_on = [aws_lambda_permission.allow_bucket]
}

#upload object to S3:
resource "aws_s3_object" "object" {
  bucket = aws_s3_bucket.bucket.id

  key    = "test.json"
  source = "uploads/test.json"
  etag   = filemd5("uploads/test.json")

  depends_on = [
    aws_s3_bucket.bucket,
  ]
}