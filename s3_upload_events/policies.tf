data "aws_iam_policy_document" "sts_lambda"{
    statement {
      actions = ["sts:AssumeRole"]
      principals {
        type = "Service"
        identifiers = ["lambda.amazonaws.com"]
      }
      effect = "Allow"
    }
}