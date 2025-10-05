#!/bin/bash
# Environment Validation Script
# This script checks if your LocalStack environment is properly configured

echo "🔍 LocalStack Environment Validation"
echo "===================================="

# Check if LocalStack is running
echo -n "📡 LocalStack service: "
if curl -s http://localhost:4566/_localstack/health > /dev/null 2>&1; then
    echo "✅ Running"
else
    echo "❌ Not running or not accessible"
    echo "   Start with: docker run --rm -it -p 127.0.0.1:4566:4566 -p 127.0.0.1:4510-4559:4510-4559 -v /var/run/docker.sock:/var/run/docker.sock localstack/localstack"
fi

# Check environment variables
echo -n "🌍 AWS_ACCESS_KEY_ID: "
if [ -n "$AWS_ACCESS_KEY_ID" ]; then
    echo "✅ Set ($AWS_ACCESS_KEY_ID)"
else
    echo "❌ Not set"
fi

echo -n "🔑 AWS_SECRET_ACCESS_KEY: "
if [ -n "$AWS_SECRET_ACCESS_KEY" ]; then
    echo "✅ Set (***hidden***)"
else
    echo "❌ Not set"
fi

echo -n "🌎 AWS_DEFAULT_REGION: "
if [ -n "$AWS_DEFAULT_REGION" ]; then
    echo "✅ Set ($AWS_DEFAULT_REGION)"
else
    echo "❌ Not set"
fi

echo -n "🔗 AWS_ENDPOINT_URL: "
if [ -n "$AWS_ENDPOINT_URL" ]; then
    echo "✅ Set ($AWS_ENDPOINT_URL)"
else
    echo "❌ Not set"
fi

echo -n "📦 AWS_S3_FORCE_PATH_STYLE: "
if [ -n "$AWS_S3_FORCE_PATH_STYLE" ]; then
    echo "✅ Set ($AWS_S3_FORCE_PATH_STYLE)"
else
    echo "❌ Not set"
fi

# Check AWS CLI profile
echo -n "⚙️  AWS Profile 'localstack': "
if aws configure list --profile localstack > /dev/null 2>&1; then
    echo "✅ Configured"
else
    echo "❌ Not configured"
fi

# Check if all environment variables are set
if [ -n "$AWS_ACCESS_KEY_ID" ] && [ -n "$AWS_SECRET_ACCESS_KEY" ] && [ -n "$AWS_DEFAULT_REGION" ] && [ -n "$AWS_ENDPOINT_URL" ] && [ -n "$AWS_S3_FORCE_PATH_STYLE" ]; then
    echo ""
    echo "🎉 Environment is properly configured!"
    echo "💡 You can now run: terraform plan"
else
    echo ""
    echo "⚠️  Environment needs configuration!"
    echo "💡 Run: source env.sh"
fi