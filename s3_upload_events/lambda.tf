# create IAM role for Lambda:
resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"
  assume_role_policy = data.aws_iam_policy_document.sts_lambda.json
}

#create zip file for Lambda:
data "archive_file" "lambda_code" {
  type        = "zip"
  source_dir  = "${path.module}/function_code"
  output_path = "${path.module}/function_code.zip"
}

#lambda function:
resource "aws_lambda_function" "func" {
  filename      = data.archive_file.lambda_code.output_path
  function_name = "S3UploadEventHandler"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "index.handler"
  runtime       = "nodejs16.x"
}

#lambda permission to allow invocation by s3:
resource "aws_lambda_permission" "allow_s3_invocation" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.func.arn
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.bucket.arn
}