output "dynamodb_table_name" {
  value = aws_dynamodb_table.dynamodb_table.name
}

output "s3_bucket_name" {
  value = aws_s3_bucket.backend_bucket.id
}