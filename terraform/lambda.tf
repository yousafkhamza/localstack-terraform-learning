
# Lambda function
resource "aws_lambda_function" "example" {
  function_name = var.lambda_function_name
  handler       = var.lambda_handler
  runtime       = var.lambda_runtime
  role          = aws_iam_role.lambda_exec.arn
  filename      = "${path.module}/files/lambda_function.zip"
  timeout       = var.timeout

  source_code_hash = filebase64sha256("${path.module}/files/lambda_function.zip")

  environment {
    variables = {
      DEMO_BUCKET = aws_s3_bucket.demo_bucket.bucket
      ENVIRONMENT = "localstack"
    }
  }

  depends_on = [
    aws_iam_role_policy_attachment.lambda_basic,
    aws_cloudwatch_log_group.lambda_logs,
  ]
}
