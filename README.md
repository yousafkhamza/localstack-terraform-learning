# LocalStack + Terraform + AWS CLI Learning Environment

This repository provides a complete local AWS environment using LocalStack for learning AWS services, Terraform infrastructure as code, and AWS CLI commands without using the AWS Console.

[![LocalStack](https://img.shields.io/badge/LocalStack-Ready-brightgreen)](https://localstack.cloud/)
[![Terraform](https://img.shields.io/badge/Terraform-1.0+-blue)](https://terraform.io/)
[![AWS CLI](https://img.shields.io/badge/AWS%20CLI-2.0+-orange)](https://aws.amazon.com/cli/)
[![Python](https://img.shields.io/badge/Python-3.9+-yellow)](https://python.org/)

## 🎯 What You'll Learn

- 🏗️ **Infrastructure as Code** with Terraform
- ⚡ **AWS Lambda** development and deployment  
- 📦 **AWS S3** operations and management
- 🔐 **IAM** roles and permissions
- 📊 **CloudWatch** logging and monitoring
- 🖥️ **AWS CLI** commands and automation
- 🐍 **Python boto3** SDK scripting
- 🎓 **No AWS Console needed** - Everything through code!

## 📋 Prerequisites

- Docker installed and running
- Terraform installed (version >= 1.0)
- AWS CLI installed (version >= 2.0)
- Python 3.9+ (for Lambda function development)

## 🚀 Quick Start

**1. Clone this repository:**
```bash
git clone <your-repo-url>
cd localstack-terraform-learning
```

**2. Start LocalStack:**
```bash
docker run \
  --rm -it \
  -p 127.0.0.1:4566:4566 \
  -p 127.0.0.1:4510-4559:4510-4559 \
  -v /var/run/docker.sock:/var/run/docker.sock \
  localstack/localstack
```

**3. Set up environment:**
```bash
source env.sh
./validate-env.sh  # Check everything is configured
```

**4. Deploy infrastructure:**
```bash
./setup.sh
terraform apply
```

**5. Test your setup:**
```bash
./test_lambda.sh
```

## 🏗️ Project Structure

```
localstack/
├── 📄 README.md                  # This documentation
├── 🔧 .gitignore                 # Git ignore rules
├── ⚙️ env.sh                     # Environment setup script
├── 🎯 setup.sh                   # Automated setup script
├── ✅ validate-env.sh             # Environment validation
├── 🧪 test_lambda.sh             # Lambda testing script
├── 🐍 aws_demo.py                # Python boto3 examples
├── 📋 aws_commands_reference.sh  # AWS CLI commands
│
├── 🏗️ Terraform Configuration:
│   ├── provider.tf               # AWS provider for LocalStack
│   ├── variables.tf              # Input variables
│   ├── lambda.tf                 # Main infrastructure
│   ├── output.tf                 # Output values
│   └── backend.conf              # S3 backend configuration
│
└── ⚡ Lambda Function:
    ├── lambda_function.py        # Main Lambda code
    ├── lambda_function_advanced.py # Advanced example
    └── lambda_function.zip       # Deployment package
```

## 🚀 Setup Instructions

### Step 1: Start LocalStack

Run LocalStack in a separate terminal window:

```bash
docker run \
  --rm -it \
  -p 127.0.0.1:4566:4566 \
  -p 127.0.0.1:4510-4559:4510-4559 \
  -v /var/run/docker.sock:/var/run/docker.sock \
  localstack/localstack
```

**Keep this terminal running throughout your learning session.**

### Step 2: Configure AWS Profile

Create a dedicated AWS profile for LocalStack:

```bash
# Configure AWS profile
aws configure set aws_access_key_id test --profile localstack
aws configure set aws_secret_access_key test --profile localstack
aws configure set region us-east-1 --profile localstack
aws configure set output json --profile localstack
```

### Step 3: Set Environment Variables

**Important:** You need to source the environment variables in your current shell session.

**Option 1: Use the provided environment script (Recommended)**
```bash
source env.sh
```

**Option 2: Export manually**
```bash
export AWS_ACCESS_KEY_ID=test
export AWS_SECRET_ACCESS_KEY=test
export AWS_DEFAULT_REGION=us-east-1
export AWS_S3_FORCE_PATH_STYLE=true
export AWS_ENDPOINT_URL=http://localhost:4566
```

**Pro Tip:** Add these to your `~/.bashrc` or `~/.zshrc` for persistent configuration:

```bash
# Add to your shell profile
echo 'export AWS_ACCESS_KEY_ID=test' >> ~/.bashrc
echo 'export AWS_SECRET_ACCESS_KEY=test' >> ~/.bashrc
echo 'export AWS_DEFAULT_REGION=us-east-1' >> ~/.bashrc
echo 'export AWS_S3_FORCE_PATH_STYLE=true' >> ~/.bashrc
echo 'export AWS_ENDPOINT_URL=http://localhost:4566' >> ~/.bashrc
source ~/.bashrc
```

### Step 4: Create Terraform State Bucket

Create the S3 bucket for Terraform state management:

```bash
aws --endpoint-url=http://localhost:4566 s3 mb s3://terraform-state-bucket --profile localstack
```

Verify bucket creation:

```bash
aws s3 ls --endpoint-url=http://localhost:4566 --profile localstack
```

### Step 5: Initialize and Deploy Infrastructure

Navigate to the project directory and run the setup script, then deploy with Terraform:

```bash
# Run the automated setup
./setup.sh

# IMPORTANT: Source the environment variables
source .localstack-env

# Plan the deployment
terraform plan

# Apply the infrastructure
terraform apply
```

**Alternative: Quick setup**
```bash
# Quick environment setup
source env.sh

# Then run Terraform
terraform init -backend-config=backend.conf
terraform plan
terraform apply
```

Type `yes` when prompted to confirm the deployment.

## 🎯 What Gets Created

This Terraform configuration creates:

1. **S3 Bucket** (`localstack-demo-bucket`) - For demonstrating S3 operations
2. **IAM Role** - For Lambda execution with proper permissions
3. **CloudWatch Log Group** - For Lambda function logs
4. **Lambda Function** - A Python function that interacts with S3

## 🧪 Testing Your Infrastructure

### Test Lambda Function

Invoke the Lambda function:

```bash
aws lambda invoke \
  --endpoint-url=http://localhost:4566 \
  --function-name localstack-demo-lambda \
  --profile localstack \
  response.json

# View the response
cat response.json
```

**Advanced testing:**
```bash
# Run comprehensive Lambda tests
./test_lambda.sh

# Test with custom event data
echo '{"user": "student", "learning": "aws"}' > event.json
aws lambda invoke \
  --endpoint-url=http://localhost:4566 \
  --function-name localstack-demo-lambda \
  --profile localstack \
  --payload file://event.json \
  response.json
```

### Explore S3 Operations

List S3 buckets:

```bash
aws s3 ls --endpoint-url=http://localhost:4566 --profile localstack
```

List objects in the demo bucket:

```bash
aws s3 ls s3://localstack-demo-bucket --endpoint-url=http://localhost:4566 --profile localstack
```

Upload a test file:

```bash
echo "Hello LocalStack!" > test.txt
aws s3 cp test.txt s3://localstack-demo-bucket/ --endpoint-url=http://localhost:4566 --profile localstack
```

### Check CloudWatch Logs

View Lambda function logs:

```bash
aws logs describe-log-groups \
  --endpoint-url=http://localhost:4566 \
  --profile localstack

aws logs describe-log-streams \
  --log-group-name "/aws/lambda/localstack-demo-lambda" \
  --endpoint-url=http://localhost:4566 \
  --profile localstack
```

## 🎓 Learning Exercises

### Exercise 1: Modify the Lambda Function

1. Edit `lambda_function.py` to add new functionality
2. Recreate the zip file: `zip lambda_function.zip lambda_function.py`
3. Update the Lambda function: `terraform apply`
4. Test your changes

### Exercise 2: Add More AWS Resources

Try adding these resources to `lambda.tf`:

- DynamoDB table
- SQS queue
- SNS topic
- API Gateway

### Exercise 3: AWS CLI Exploration

Practice common AWS CLI commands:

```bash
# IAM operations
aws iam list-roles --endpoint-url=http://localhost:4566 --profile localstack

# Lambda operations
aws lambda list-functions --endpoint-url=http://localhost:4566 --profile localstack

# S3 operations
aws s3api list-buckets --endpoint-url=http://localhost:4566 --profile localstack
```

## 📚 Python Boto3 Scripting

Create Python scripts to interact with your LocalStack environment:

```python
import boto3

# Initialize clients
s3 = boto3.client(
    's3',
    endpoint_url='http://localhost:4566',
    aws_access_key_id='test',
    aws_secret_access_key='test',
    region_name='us-east-1'
)

lambda_client = boto3.client(
    'lambda',
    endpoint_url='http://localhost:4566',
    aws_access_key_id='test',
    aws_secret_access_key='test',
    region_name='us-east-1'
)

# Example operations
buckets = s3.list_buckets()
functions = lambda_client.list_functions()
```

## 🔧 Troubleshooting

### Common Issues

1. **LocalStack not running**: Ensure Docker container is running on port 4566
2. **Environment variables not set**: Run `source env.sh` or `source .localstack-env` before Terraform commands
3. **"InvalidClientTokenId" error**: This means environment variables aren't set in your current shell. Run `source env.sh` and try again
4. **Permission denied**: Check that environment variables are properly set
5. **Terraform init fails**: Ensure the state bucket exists and environment variables are set
6. **Lambda function fails**: Check CloudWatch logs for errors

### Environment Variable Troubleshooting

If you see errors like:
```
Error: Retrieving AWS account details: AWS account ID not previously found and failed retrieving via all available methods.
```

This means the environment variables aren't set in your current shell. Fix it by:

```bash
# Check if variables are set
echo $AWS_ENDPOINT_URL

# If empty, source the environment
source env.sh

# Verify they're now set
echo $AWS_ENDPOINT_URL
```

### Useful Commands

```bash
# Check LocalStack status
curl http://localhost:4566/_localstack/health

# Reset LocalStack (clears all data)
docker stop <container_id>
# Then restart LocalStack

# Terraform troubleshooting
terraform validate
terraform fmt
terraform show
```

## 🧹 Cleanup

To destroy all resources:

```bash
terraform destroy
```

To stop LocalStack:

```bash
# In the LocalStack terminal, press Ctrl+C
```

## 📖 Additional Learning Resources

- [LocalStack Documentation](https://docs.localstack.cloud/)
- [Terraform AWS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [AWS CLI Reference](https://docs.aws.amazon.com/cli/latest/reference/)
- [Boto3 Documentation](https://boto3.amazonaws.com/v1/documentation/api/latest/index.html)

## 🎯 Next Steps

1. Explore other AWS services available in LocalStack
2. Build more complex infrastructure patterns
3. Practice CI/CD with Terraform and LocalStack
4. Learn about Terraform modules and best practices

## 🔗 GitHub Setup

This repository is configured with a comprehensive `.gitignore` file that excludes:
- Terraform state files and directories
- Environment configuration files  
- AWS credentials
- Temporary and cache files
- IDE-specific files

### First Time Setup:
```bash
# Initialize and add files
git add .
git commit -m "Initial commit: LocalStack + Terraform learning environment"

# Add your GitHub repository
git remote add origin https://github.com/yourusername/your-repo-name.git
git branch -M main
git push -u origin main
```

### Regular Updates:
```bash
git add .
git commit -m "Update: describe your changes"
git push
```

**⚠️ Important:** Never commit `.env`, `.localstack-env`, or Terraform state files to public repositories!

Happy learning! 🚀