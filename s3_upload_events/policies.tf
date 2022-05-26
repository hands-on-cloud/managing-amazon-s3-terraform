data "aws_iam_policy_document" "sts_lambda" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
    effect = "Allow"
  }
}

data "aws_iam_policy_document" "lambda_execution" {
  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
    ]
    effect    = "Allow"
    resources = ["${aws_cloudwatch_log_group.lambda_log_group.arn}*:*"]
  }
  statement {
    actions = [
      "logs:PutLogEvents"
    ]
    effect    = "Allow"
    resources = ["${aws_cloudwatch_log_group.lambda_log_group.arn}*:*:*"]
  }
  statement {
    actions = [
      "s3:GetObject",
    ]
    effect = "Allow"
    resources = [
      aws_s3_bucket.bucket.arn,
      "${aws_s3_bucket.bucket.arn}/*",
    ]
  }
}