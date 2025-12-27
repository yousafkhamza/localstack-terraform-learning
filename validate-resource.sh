#!/bin/bash
# LocalStack Resource Validation Script (Structured + CloudWatch)

PROFILE="localstack"
REGION="us-east-1"

# 🔹 Change this if your log group name is different
CW_LOG_PREFIX="/aws/lambda"

echo "⚠️  Make sure resources are created before running this script"
echo "👉 Run terraform apply first"
echo ""

echo "🔍 Validating LocalStack resources"
echo "================================="

# --------------------
# VPC
# --------------------
echo ""
echo "🌐 VPCs:"
aws ec2 describe-vpcs \
  --profile "$PROFILE" \
  --region "$REGION" \
  --query 'Vpcs[].VpcId' \
  --output table

# --------------------
# Subnets
# --------------------
echo ""
echo "📦 Subnets:"
aws ec2 describe-subnets \
  --profile "$PROFILE" \
  --region "$REGION" \
  --query 'Subnets[].SubnetId' \
  --output table

# --------------------
# Security Groups
# --------------------
echo ""
echo "🔐 Security Groups:"
aws ec2 describe-security-groups \
  --profile "$PROFILE" \
  --region "$REGION" \
  --query 'SecurityGroups[].GroupName' \
  --output table

# --------------------
# EC2
# --------------------
echo ""
echo "🖥️ EC2 Instances:"
aws ec2 describe-instances \
  --profile "$PROFILE" \
  --region "$REGION" \
  --query 'Reservations[].Instances[].InstanceId' \
  --output table

echo ""
echo "🔑 EC2 Key Pairs:"
aws ec2 describe-key-pairs \
  --profile "$PROFILE" \
  --region "$REGION" \
  --query 'KeyPairs[].KeyName' \
  --output table

# --------------------
# Lambda
# --------------------
echo ""
echo "⚡ Lambda Functions:"
LAMBDA_NAMES=$(aws lambda list-functions \
  --profile "$PROFILE" \
  --region "$REGION" \
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
      --region "$REGION" \
      response.json > /dev/null

    echo "Response:"
    cat response.json | jq '.body | fromjson' 2>/dev/null || cat response.json
  done
fi

# --------------------
# CloudWatch (ONLY created log groups)
# --------------------
echo ""
echo "📊 CloudWatch Log Groups (Terraform-created only):"

LOG_GROUPS=$(aws logs describe-log-groups \
  --profile "$PROFILE" \
  --region "$REGION" \
  --log-group-name-prefix "$CW_LOG_PREFIX" \
  --query 'logGroups[].logGroupName' \
  --output text)

if [ -z "$LOG_GROUPS" ]; then
  echo "❌ No CloudWatch log groups found with prefix: $CW_LOG_PREFIX"
else
  for LG in $LOG_GROUPS; do
    echo ""
    echo "📂 Log Group: $LG"

    STREAM=$(aws logs describe-log-streams \
      --log-group-name "$LG" \
      --profile "$PROFILE" \
      --region "$REGION" \
      --order-by LastEventTime \
      --descending \
      --query 'logStreams[0].logStreamName' \
      --output text)

    if [ "$STREAM" != "None" ] && [ -n "$STREAM" ]; then
      aws logs get-log-events \
        --log-group-name "$LG" \
        --log-stream-name "$STREAM" \
        --limit 5 \
        --profile "$PROFILE" \
        --region "$REGION" \
        --query 'events[].message' \
        --output text
    else
      echo "⚠️ No log streams yet (invoke Lambda to generate logs)"
    fi
  done
fi

# --------------------
# S3
# --------------------
echo ""
echo "🪣 S3 Buckets:"
aws s3 ls --profile "$PROFILE" --region "$REGION"

# --------------------
# Cleanup
# --------------------
rm -f response.json

echo ""
echo "✅ Resource validation completed successfully"
