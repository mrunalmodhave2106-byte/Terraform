provider "aws" {
  region = "us-east-1"   
}

resource "aws_security_group" "my_sg" {
  name        = "my-security-group"
  description = "Allow SSH and "

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "my-sg"
  }
}
resource "aws_instance" "ec2" {
    ami = "ami-0f3caa1cf4417e51b"
    instance_type = "t3.micro"
    vpc_security_group_ids = [ "aws_security_group.my_sg" ]
  
}