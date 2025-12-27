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
  access_key                  = "test"
  secret_key                  = "test"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true
  s3_use_path_style          = true
  
  endpoints {
    lambda     = "http://localhost:4566"
    s3         = "http://localhost:4566"
    iam        = "http://localhost:4566"
    sts        = "http://localhost:4566"
    logs       = "http://localhost:4566"
    cloudwatch = "http://localhost:4566"
    ec2        = "http://localhost:4566"
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