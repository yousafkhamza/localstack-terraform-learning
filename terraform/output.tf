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

output "ec2_instance_id" {
  description = "EC2 instance ID"
  value       = aws_instance.demo.id
}

output "ec2_private_ip" {
  description = "EC2 private IP"
  value       = aws_instance.demo.private_ip
}

output "security_group_id" {
  description = "Security group ID"
  value       = aws_security_group.demo.id
}

output "subnet_id" {
  description = "Subnet ID"
  value       = aws_subnet.demo.id
}

output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.demo.id
}
