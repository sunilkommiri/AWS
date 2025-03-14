provider "aws" {
  region = "us-east-1"
}


# Generate a new private key
resource "tls_private_key" "key_pair" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

# Create an AWS Key Pair using the generated public key
resource "aws_key_pair" "key_pair" {
  key_name   = "first_key_pair"
  public_key = tls_private_key.key_pair.public_key_openssh
}

# Launch EC2 instance with the generated key pair
resource "aws_instance" "first_instance" {
  ami              = "ami-08b5b3a93ed654d19"              
  instance_type    = "t2.micro"             
  subnet_id        = "subnet-0e61d6ec93aeba6bd"
  security_group_ids = ["sg-0c65cc2cc8cc7ffcb"]
  key_name         = aws_key_pair.key_pair.key_name

  associate_public_ip_address = true

  tags = {
    Name = "first_instance"
  }
}

# Output the private key
output "private_key" {
  value     = tls_private_key.key_pair.private_key_pem
  sensitive = true
}
