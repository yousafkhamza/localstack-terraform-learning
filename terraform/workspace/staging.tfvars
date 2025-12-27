region               = "us-east-1"

lambda_function_name = "localstack-demo-lambda"
lambda_handler       = "lambda_function.lambda_handler"
lambda_runtime       = "python3.9"
timeout              = 30

s3_bucket_name        = "localstack-demo-bucket"

environment        = "staging"

vpc_cidr           = "10.0.0.0/16"
subnet_cidr        = "10.0.1.0/24"
availability_zone  = "us-east-1a"

instance_ami       = "ami-0abcdef1234567890"
instance_type      = "t2.micro"

key_pair_name      = "localstack-demo-key"

allowed_ssh_cidr   = ["0.0.0.0/0"]
allowed_http_cidr  = ["0.0.0.0/0"]
