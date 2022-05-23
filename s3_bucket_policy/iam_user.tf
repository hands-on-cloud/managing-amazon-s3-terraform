resource "aws_iam_user" "user" {
  name = var.iam_username

  tags = {
    Project = "hands-on.cloud"
  }
}

resource "aws_iam_user_login_profile" "login" {
  user = aws_iam_user.user.name
}


resource "aws_iam_policy" "policy" {
  name        = "S3ListPolicy"
  description = "Allow listing S3 buckets"
  policy      = data.aws_iam_policy_document.s3_list.json
}

resource "aws_iam_user_policy_attachment" "attach" {
  user       = aws_iam_user.user.name
  policy_arn = aws_iam_policy.policy.arn
}