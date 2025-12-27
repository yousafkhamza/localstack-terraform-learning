#!/bin/bash
# LocalStack Resource Validation & Lambda Test Script (Dynamic)

PROFILE="localstack"

echo "⚠️  Make sure resources are created before running this script"
echo "👉 Run Terraform to create resources"
echo ""

echo "🔍 Validating LocalStack resources"
echo "================================="

# --------------------
# Lambda
# --------------------
echo ""
echo "⚡ Lambda functions:"
LAMBDA_NAMES=$(aws lambda list-functions \
  --profile "$PROFILE" \
  --query 'Functions[].FunctionName' \
  --output text)

if [ -z "$LAMBDA_NAMES" ]; then
  echo "❌ No Lambda functions found"
else
  for LAMBDA in $LAMBDA_NAMES; do
    echo ""
    echo "🚀 Invoking Lambda: $LAMBDA"
    aws lambda invoke \
      --function-name "$LAMBDA" \
      --profile "$PROFILE" \
      response.json > /dev/null

    echo "Response:"
    cat response.json | jq '.body | fromjson' 2>/dev/null || cat response.json
  done
fi

# --------------------
# S3
# --------------------
echo ""
echo "📦 S3 buckets:"
aws s3 ls --profile "$PROFILE"

# --------------------
# EC2 & Networking
# --------------------
echo ""
echo "🖥️ EC2 instances:"
aws ec2 describe-instances \
  --profile "$PROFILE" \
  --query 'Reservations[].Instances[].InstanceId' \
  --output table

echo ""
echo "🔑 EC2 key pairs:"
aws ec2 describe-key-pairs \
  --profile "$PROFILE" \
  --query 'KeyPairs[].KeyName' \
  --output table

echo ""
echo "🔐 Security groups:"
aws ec2 describe-security-groups \
  --profile "$PROFILE" \
  --query 'SecurityGroups[].GroupName' \
  --output table

echo ""
echo "🌐 VPCs:"
aws ec2 describe-vpcs \
  --profile "$PROFILE" \
  --query 'Vpcs[].VpcId' \
  --output table

echo ""
echo "📡 Subnets:"
aws ec2 describe-subnets \
  --profile "$PROFILE" \
  --query 'Subnets[].SubnetId' \
  --output table

# --------------------
# Cleanup
# --------------------
rm -f response.json

echo ""
echo "✅ Resource validation completed"
