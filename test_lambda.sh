#!/bin/bash

# Lambda Testing Script for LocalStack
# This script demonstrates various ways to test Lambda functions

echo "⚡ Lambda Function Testing Script"
echo "================================="

# Check if environment is set up
if [ -z "$AWS_ENDPOINT_URL" ]; then
    echo "❌ Environment not set up. Run: source env.sh"
    exit 1
fi

echo "🔍 Available Lambda functions:"
aws lambda list-functions --endpoint-url=http://localhost:4566 --profile localstack --query 'Functions[].FunctionName' --output table

echo ""
echo "🚀 Testing Lambda function with different payloads..."

# Test 1: Simple invocation
echo "📝 Test 1: Simple invocation (no payload)"
aws lambda invoke \
    --endpoint-url=http://localhost:4566 \
    --function-name localstack-demo-lambda \
    --profile localstack \
    response1.json

echo "Response:"
cat response1.json | jq '.body | fromjson' 2>/dev/null || cat response1.json
echo ""


# Cleanup
rm -f test_event.json latest_stream.txt response1.json response2.json response3.json

echo ""
echo "✅ Lambda testing completed!"
echo "💡 Try modifying the Lambda function and running terraform apply to see changes"