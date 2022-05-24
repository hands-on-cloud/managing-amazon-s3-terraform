#create IAM role for S3 replication:
resource "aws_iam_role" "replication"{
    name = "tf-s3-replication-role"
    assume_role_policy = data.aws_iam_policy_document.sts.json
}

resource "aws_iam_policy" "replication" {
  name = "tf-s3-replication-policy"
  policy = data.aws_iam_policy_document.replication.json
}

resource "aws_iam_role_policy_attachment" "attach" {
  role       = aws_iam_role.replication.name
  policy_arn = aws_iam_policy.replication.arn
}