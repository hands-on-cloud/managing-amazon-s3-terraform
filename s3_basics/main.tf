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

#terraform s3 - creating a bucket ACL:
resource "aws_s3_bucket_acl" "bucket_acl" {
  bucket = aws_s3_bucket.bucket.id
  acl    = "private"
}

#terraform s3 - block public access:
resource "aws_s3_bucket_public_access_block" "block" {
  bucket = aws_s3_bucket.bucket.id

  block_public_acls   = true
  block_public_policy = true
}
