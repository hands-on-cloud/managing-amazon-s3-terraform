resource "aws_iam_user" "user" {
  name = var.iam_username

  tags = {
    Project = "hands-on.cloud"
  }
}

resource "aws_iam_user_login_profile" "login" {
  user = aws_iam_user.user.name
}

