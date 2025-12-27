resource "aws_key_pair" "demo" {
  key_name   = var.key_pair_name
  public_key = file("./files/localstack_demo.pub")
}