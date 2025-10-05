# Common AWS CLI Commands for LocalStack Learning

# Always include these flags for LocalStack
LOCALSTACK_FLAGS="--endpoint-url=http://localhost:4566 --profile localstack"

# S3 Commands
echo "📦 S3 Commands"
echo "List all buckets:"
echo "aws s3 ls $LOCALSTACK_FLAGS"
echo ""
echo "Create a bucket:"
echo "aws s3 mb s3://my-test-bucket $LOCALSTACK_FLAGS"
echo ""
echo "Upload a file:"
echo "aws s3 cp myfile.txt s3://my-test-bucket/ $LOCALSTACK_FLAGS"
echo ""
echo "List bucket contents:"
echo "aws s3 ls s3://my-test-bucket $LOCALSTACK_FLAGS"
echo ""
echo "Download a file:"
echo "aws s3 cp s3://my-test-bucket/myfile.txt ./downloaded-file.txt $LOCALSTACK_FLAGS"
echo ""

# Lambda Commands
echo "⚡ Lambda Commands"
echo "List functions:"
echo "aws lambda list-functions $LOCALSTACK_FLAGS"
echo ""
echo "Invoke a function:"
echo "aws lambda invoke --function-name localstack-demo-lambda response.json $LOCALSTACK_FLAGS"
echo ""
echo "Get function configuration:"
echo "aws lambda get-function --function-name localstack-demo-lambda $LOCALSTACK_FLAGS"
echo ""

# IAM Commands
echo "🔐 IAM Commands"
echo "List roles:"
echo "aws iam list-roles $LOCALSTACK_FLAGS"
echo ""
echo "List policies:"
echo "aws iam list-policies $LOCALSTACK_FLAGS"
echo ""
echo "Get role details:"
echo "aws iam get-role --role-name lambda_exec_role $LOCALSTACK_FLAGS"
echo ""

# CloudWatch Logs Commands
echo "📊 CloudWatch Logs Commands"
echo "List log groups:"
echo "aws logs describe-log-groups $LOCALSTACK_FLAGS"
echo ""
echo "List log streams:"
echo "aws logs describe-log-streams --log-group-name '/aws/lambda/localstack-demo-lambda' $LOCALSTACK_FLAGS"
echo ""
echo "Get log events:"
echo "aws logs get-log-events --log-group-name '/aws/lambda/localstack-demo-lambda' --log-stream-name 'STREAM_NAME' $LOCALSTACK_FLAGS"
echo ""

# Useful LocalStack Commands
echo "🔧 LocalStack Utility Commands"
echo "Check LocalStack health:"
echo "curl http://localhost:4566/_localstack/health"
echo ""
echo "List all LocalStack services:"
echo "curl http://localhost:4566/_localstack/health | jq"
echo ""

echo "💡 Pro Tips:"
echo "- Always use the --profile localstack flag"
echo "- Use --endpoint-url=http://localhost:4566 for all commands"
echo "- Check the README.md for complete examples"
echo "- Run ./aws_demo.py for boto3 examples"