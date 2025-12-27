# S3 bucket for demo purposes
resource "aws_s3_bucket" "demo_bucket" {
  bucket = var.s3_bucket_name
}