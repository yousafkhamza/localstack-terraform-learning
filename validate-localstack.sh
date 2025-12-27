#!/bin/bash
# LocalStack Environment Validation Script
# Uses AWS profile-based configuration (recommended)

PROFILE="localstack"

echo "🔍 LocalStack Environment Validation"
echo "===================================="

# Check if LocalStack is running
echo -n "📡 LocalStack service: "
if curl -s http://localhost:4566/_localstack/health > /dev/null 2>&1; then
    echo "✅ Running"
else
    echo "❌ Not running or not accessible"
    echo "   Start with:"
    echo "   docker run --rm -it -p 127.0.0.1:4566:4566 -p 127.0.0.1:4510-4559:4510-4559 -v /var/run/docker.sock:/var/run/docker.sock localstack/localstack"
    exit 1
fi

# Check AWS profile exists
echo -n "⚙️  AWS profile '$PROFILE': "
if aws configure list --profile "$PROFILE" > /dev/null 2>&1; then
    echo "✅ Configured"
else
    echo "❌ Not configured"
    echo "   Run: aws configure --profile $PROFILE"
    exit 1
fi

# Check endpoint_url in ~/.aws/config
echo -n "🔗 endpoint_url configured: "
ENDPOINT=$(aws configure get endpoint_url --profile "$PROFILE")
if [ -n "$ENDPOINT" ]; then
    echo "✅ $ENDPOINT"
else
    echo "❌ Missing"
    echo "   Add to ~/.aws/config:"
    echo "   [profile $PROFILE]"
    echo "   endpoint_url = http://localhost:4566"
    exit 1
fi

# STS connectivity test (no resources required)
echo -n "🪪 STS connectivity test: "
if aws sts get-caller-identity --profile "$PROFILE" > /dev/null 2>&1; then
    echo "✅ Success"
else
    echo "❌ Failed"
    echo "   AWS CLI cannot reach LocalStack STS"
    exit 1
fi

echo ""
echo "🎉 LocalStack environment is properly configured!"
echo "💡 Use AWS CLI with: --profile $PROFILE"
echo "💡 Safe to proceed with Terraform or AWS CLI commands"
