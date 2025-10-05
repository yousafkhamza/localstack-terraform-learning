# Contributing to LocalStack Learning Environment

Thank you for your interest in contributing to this LocalStack learning project! This guide will help you get started.

## 🚀 Quick Setup for Contributors

1. **Fork and clone the repository:**
   ```bash
   git clone https://github.com/yourusername/localstack-terraform-learning.git
   cd localstack-terraform-learning
   ```

2. **Ensure you have the prerequisites:**
   - Docker
   - Terraform >= 1.0
   - AWS CLI >= 2.0
   - Python 3.9+

3. **Set up your development environment:**
   ```bash
   # Start LocalStack
   docker run --rm -it -p 127.0.0.1:4566:4566 -p 127.0.0.1:4510-4559:4510-4559 -v /var/run/docker.sock:/var/run/docker.sock localstack/localstack

   # In another terminal, set up the environment
   source env.sh
   ./validate-env.sh
   ```

## 📋 Development Workflow

1. **Create a feature branch:**
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. **Make your changes and test:**
   ```bash
   # Test infrastructure changes
   terraform plan
   terraform apply

   # Test Lambda functions
   ./test_lambda.sh

   # Test Python scripts
   python3 aws_demo.py
   ```

3. **Commit your changes:**
   ```bash
   git add .
   git commit -m "feat: describe your changes"
   ```

4. **Push and create a Pull Request:**
   ```bash
   git push origin feature/your-feature-name
   ```

## 🎯 Areas for Contribution

- **New AWS Services:** Add examples for DynamoDB, SQS, SNS, etc.
- **Advanced Lambda Functions:** More complex use cases and patterns
- **Documentation:** Improve setup guides, add troubleshooting tips
- **Testing:** Add more comprehensive test scripts
- **Automation:** Improve setup and deployment scripts

## 🔍 Testing Guidelines

Before submitting a PR, ensure:

1. **Environment validation passes:**
   ```bash
   ./validate-env.sh
   ```

2. **Terraform configuration is valid:**
   ```bash
   terraform validate
   terraform fmt -check
   ```

3. **Lambda functions work correctly:**
   ```bash
   ./test_lambda.sh
   ```

4. **Python scripts execute without errors:**
   ```bash
   python3 aws_demo.py
   ```

## 📝 Commit Message Format

Use conventional commits:
- `feat:` for new features
- `fix:` for bug fixes  
- `docs:` for documentation changes
- `test:` for adding tests
- `refactor:` for code refactoring

## 🚫 What NOT to Commit

The `.gitignore` file excludes:
- `.terraform/` directories
- `terraform.tfstate*` files
- `.env` and `.localstack-env` files
- AWS credentials
- Temporary files and IDE configurations

## 🆘 Getting Help

- Check the main README.md for setup instructions
- Run `./validate-env.sh` to diagnose environment issues
- Look at existing code examples for patterns
- Open an issue for questions or problems

Thank you for contributing! 🙌