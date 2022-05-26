# create IAM role for Lambda:
resource "aws_iam_role" "iam_for_lambda" {
  name               = "iam_for_lambda"
  assume_role_policy = data.aws_iam_policy_document.sts_lambda.json
}

#create IAM Policy for lambda execution:
resource "aws_iam_policy" "lambda_execution_policy" {
  policy = data.aws_iam_policy_document.lambda_execution.json
  name   = "s3_event_lambda_execution_policy"
}

#attach the lambda execution role: 
resource "aws_iam_role_policy_attachment" "attach" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = aws_iam_policy.lambda_execution_policy.arn
}
