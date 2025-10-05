output "lambda_function_name" {
  description = "Name of the Lambda function"
  value       = aws_lambda_function.example.function_name
}

output "lambda_function_arn" {
  description = "ARN of the Lambda function"
  value       = aws_lambda_function.example.arn
}

output "s3_bucket_name" {
  description = "Name of the demo S3 bucket"
  value       = aws_s3_bucket.demo_bucket.bucket
}

output "iam_role_arn" {
  description = "ARN of the Lambda execution role"
  value       = aws_iam_role.lambda_exec.arn
}
