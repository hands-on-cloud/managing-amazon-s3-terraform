#terraform s3 - bucket name
output "s3_bucket_name" {
  value = aws_s3_bucket.bucket.id
}
#IAM user details:
output "iam_user_arn" {
  value = aws_iam_user.user.arn
}

output "iam_user_id" {
  value = aws_iam_user.user.id
}

output "iam_user_password" {
  value = aws_iam_user_login_profile.login.password
}


