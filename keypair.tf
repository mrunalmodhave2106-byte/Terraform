    provider "aws" {
      region = "us-east-1"  # Change to your desired AWS region
    }
    
    resource "aws_key_pair" "tf-key-pair" {
    
        key_name = "my-tf-key"
    
        public_key = tls_private_key.rsa.public_key_openssh
    
    }
    
    resource "tls_private_key" "rsa" {
    
        algorithm = "RSA"
    
        rsa_bits  = 4096
    
    }
    
    resource "local_file" "tf-key" {
    
       content  = tls_private_key.rsa.private_key_pem
    
       filename = "my-tf-key"
    
    }


  resource "aws_instance" "my_instance" {
    ami           = "ami-0c55b159cbfafe1f0"  # Replace with a valid AMI ID
    instance_type = "t3.micro"
    key_name      = aws_key_pair.tf-key-pair.key_name  # Attach the key pair
  
    tags = {
      Name = "MyTerraformEC2"
    }
  }