#!/bin/bash

# LocalStack Environment Setup Script
# This script sets up the complete environment for learning AWS with LocalStack

set -e

echo "🚀 Setting up LocalStack Learning Environment..."

# Check if LocalStack is running
echo "📋 Checking LocalStack status..."
if curl -s http://localhost:4566/_localstack/health > /dev/null; then
    echo "✅ LocalStack is running"
else
    echo "❌ LocalStack is not running. Please start it first:"
    echo "docker run --rm -it -p 127.0.0.1:4566:4566 -p 127.0.0.1:4510-4559:4510-4559 -v /var/run/docker.sock:/var/run/docker.sock localstack/localstack"
    exit 1
fi

# Configure AWS profile
echo "🔧 Configuring AWS profile..."
aws configure set aws_access_key_id test --profile localstack
aws configure set aws_secret_access_key test --profile localstack
aws configure set region us-east-1 --profile localstack
aws configure set output json --profile localstack

# Export environment variables
echo "🌍 Setting environment variables..."
export AWS_ACCESS_KEY_ID=test
export AWS_SECRET_ACCESS_KEY=test
export AWS_DEFAULT_REGION=us-east-1
export AWS_S3_FORCE_PATH_STYLE=true
export AWS_ENDPOINT_URL=http://localhost:4566

# Create environment file for sourcing
echo "📝 Creating environment file..."
cat > .localstack-env << EOF
export AWS_ACCESS_KEY_ID=test
export AWS_SECRET_ACCESS_KEY=test
export AWS_DEFAULT_REGION=us-east-1
export AWS_S3_FORCE_PATH_STYLE=true
export AWS_ENDPOINT_URL=http://localhost:4566
EOF

echo "⚠️  IMPORTANT: Run the following command to set environment variables in your current shell:"
echo "source .localstack-env"
echo ""

# Create Terraform state bucket
echo "🪣 Creating Terraform state bucket..."
aws --endpoint-url=http://localhost:4566 s3 mb s3://terraform-state-bucket --profile localstack 2>/dev/null || echo "Bucket already exists"

# Verify bucket creation
echo "🔍 Verifying bucket creation..."
aws s3 ls --endpoint-url=http://localhost:4566 --profile localstack

# Initialize Terraform
echo "🏗️  Initializing Terraform..."
terraform init -backend-config=backend.conf

echo "✅ Environment setup complete!"
echo ""
echo "⚠️  BEFORE running Terraform commands, make sure to source the environment:"
echo "source .localstack-env"
echo ""
echo "Next steps:"
echo "1. Run: source .localstack-env"
echo "2. Run: terraform plan"
echo "3. Run: terraform apply"
echo "4. Test your infrastructure with the commands in README.md"
echo ""
echo "🎓 Happy learning!"