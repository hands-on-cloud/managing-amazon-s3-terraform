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

  for_each = fileset("uploads/", "*")
  key    = each.value
  source = "uploads/${each.value}"
  etag = filemd5("uploads/${each.value}")

  depends_on = [
    aws_s3_bucket.bucket
  ]
}