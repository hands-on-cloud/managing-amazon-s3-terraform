output "source_bucket_name" {
  value = aws_s3_bucket.src.id
}

output "destination_bucket_name" {
  value = aws_s3_bucket.dest.id
}