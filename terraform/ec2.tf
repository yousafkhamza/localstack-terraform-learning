resource "aws_instance" "demo" {
  ami           = var.instance_ami
  instance_type = var.instance_type
  key_name      = aws_key_pair.demo.key_name

  subnet_id              = aws_subnet.demo.id
  vpc_security_group_ids = [aws_security_group.demo.id]

  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello from LocalStack EC2" > /tmp/hello.txt
              EOF
}
