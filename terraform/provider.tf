terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.50"
    }
  }
  backend "s3" {}
}

provider "aws" {
  region                      = var.region
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true
  s3_use_path_style           = true
  
endpoints {
  # Core
  sts        = "http://localhost:4566"
  iam        = "http://localhost:4566"

  # Storage
  s3         = "http://localhost:4566"
  dynamodb   = "http://localhost:4566"

  # Compute
  lambda     = "http://localhost:4566"
  ec2        = "http://localhost:4566"

  # Networking (metadata-only)
  elb        = "http://localhost:4566"
  elbv2      = "http://localhost:4566"

  # Messaging
  sqs        = "http://localhost:4566"
  sns        = "http://localhost:4566"

  # Events
  events     = "http://localhost:4566"   # EventBridge / CloudWatch Events
  scheduler  = "http://localhost:4566"   # EventBridge Scheduler

  # Observability
  logs       = "http://localhost:4566"
  cloudwatch = "http://localhost:4566"

  # API & App
  apigateway    = "http://localhost:4566"
  stepfunctions = "http://localhost:4566"

  # Configuration & Secrets
  ssm            = "http://localhost:4566"
  secretsmanager = "http://localhost:4566"

  # Streaming (limited)
  kinesis    = "http://localhost:4566"
  firehose   = "http://localhost:4566"

  # Search (limited)
  opensearch = "http://localhost:4566"
}


  default_tags {
    tags = {
      Environment = var.environment
      ManagedBy   = "terraform"
      Project     = "localstack-learning"
      Owner       = "yousaf"
    }
  }
}
