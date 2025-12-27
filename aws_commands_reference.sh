# Common AWS CLI Commands for LocalStack Learning
# Assumes AWS profile "localstack" is already configured

AWS_PROFILE=localstack

# --------------------
# S3 Commands
# --------------------
echo "📦 S3 Commands"

echo "List all buckets:"
echo "aws s3 ls --profile $AWS_PROFILE"
echo ""

echo "Create a bucket:"
echo "aws s3 mb s3://my-test-bucket --profile $AWS_PROFILE"
echo ""

echo "Upload a file:"
echo "aws s3 cp myfile.txt s3://my-test-bucket/ --profile $AWS_PROFILE"
echo ""

echo "List bucket contents:"
echo "aws s3 ls s3://my-test-bucket --profile $AWS_PROFILE"
echo ""

echo "Download a file:"
echo "aws s3 cp s3://my-test-bucket/myfile.txt ./downloaded-file.txt --profile $AWS_PROFILE"
echo ""

# --------------------
# Lambda Commands
# --------------------
echo "⚡ Lambda Commands"

echo "List functions:"
echo "aws lambda list-functions --profile $AWS_PROFILE"
echo ""

echo "Invoke a function:"
echo "aws lambda invoke --function-name localstack-demo-lambda response.json --profile $AWS_PROFILE"
echo ""

echo "Get function configuration:"
echo "aws lambda get-function --function-name localstack-demo-lambda --profile $AWS_PROFILE"
echo ""

# --------------------
# IAM Commands
# --------------------
echo "🔐 IAM Commands"

echo "List roles:"
echo "aws iam list-roles --profile $AWS_PROFILE"
echo ""

echo "List policies:"
echo "aws iam list-policies --profile $AWS_PROFILE"
echo ""

echo "Get role details:"
echo "aws iam get-role --role-name lambda_exec_role --profile $AWS_PROFILE"
echo ""

# --------------------
# EC2 Commands
# --------------------
echo "🖥️ EC2 Commands"

echo "List EC2 instances:"
echo "aws ec2 describe-instances --profile $AWS_PROFILE"
echo ""

echo "Describe instance states:"
echo "aws ec2 describe-instances --query 'Reservations[].Instances[].State.Name' --profile $AWS_PROFILE"
echo ""

echo "List key pairs:"
echo "aws ec2 describe-key-pairs --profile $AWS_PROFILE"
echo ""

echo "List security groups:"
echo "aws ec2 describe-security-groups --profile $AWS_PROFILE"
echo ""

# --------------------
# VPC Commands
# --------------------
echo "🌐 VPC Commands"

echo "List VPCs:"
echo "aws ec2 describe-vpcs --profile $AWS_PROFILE"
echo ""

echo "List subnets:"
echo "aws ec2 describe-subnets --profile $AWS_PROFILE"
echo ""

echo "List route tables:"
echo "aws ec2 describe-route-tables --profile $AWS_PROFILE"
echo ""

# --------------------
# CloudWatch Logs Commands
# --------------------
echo "📊 CloudWatch Logs Commands"

echo "List log groups:"
echo "aws logs describe-log-groups --profile $AWS_PROFILE"
echo ""

echo "List log streams:"
echo "aws logs describe-log-streams --log-group-name '/aws/lambda/localstack-demo-lambda' --profile $AWS_PROFILE"
echo ""

echo "Get log events:"
echo "aws logs get-log-events --log-group-name '/aws/lambda/localstack-demo-lambda' --log-stream-name 'STREAM_NAME' --profile $AWS_PROFILE"
echo ""

# --------------------
# LocalStack Utility
# --------------------
echo "🧪 LocalStack Utility Commands"

echo "Check LocalStack health:"
echo "curl http://localhost:4566/_localstack/health"
echo ""

echo "Pretty print LocalStack services:"
echo "curl http://localhost:4566/_localstack/health | jq"
echo ""

# --------------------
# Pro Tips
# --------------------
echo "💡 Pro Tips:"
echo "- EC2 resources are MOCKED in LocalStack (no real VM)"
echo "- KeyPair format must be valid OpenSSH"
echo "- Terraform + AWS CLI share the same LocalStack state"
echo "- Safe for CI/CD testing without AWS costs"
echo "- Use --endpoint-url http://localhost:4566 for direct service access"