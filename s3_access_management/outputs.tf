#terraform s3 - bucket name
output "s3_bucket_name" {
  value = aws_s3_bucket.bucket.id
}

output "s3_object_key" {
  value = aws_s3_object.object.key
}