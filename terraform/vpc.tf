resource "aws_vpc" "demo" {
  cidr_block = var.vpc_cidr

  tags = {
    Name        = "demo-vpc"
    Environment = var.environment
  }
}

resource "aws_subnet" "demo" {
  vpc_id            = aws_vpc.demo.id
  cidr_block        = var.subnet_cidr
  availability_zone = var.availability_zone
}
