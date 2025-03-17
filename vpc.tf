provider "aws" {
  region = "us-east-1"
}

# Create VPC
resource "aws_vpc" "First_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "first_Vpc"
  }
}

# Create Subnet 1
resource "aws_subnet" "subnet1" {
  availability_zone = "us-east-1a"
  vpc_id            = aws_vpc.First_vpc.id
  cidr_block        = "10.0.1.0/24"
  tags = {
    Name = "subnet1"
  }
}

# Create Subnet 2
resource "aws_subnet" "subnet2" {
  availability_zone = "us-east-1b"
  vpc_id            = aws_vpc.First_vpc.id
  cidr_block        = "10.0.2.0/24"
  tags = {
    Name = "subnet2"
  }
}

# Create Internet Gateway
resource "aws_internet_gateway" "first_igw" {
  vpc_id = aws_vpc.First_vpc.id
  tags = {
    Name = "first_igw"
  }
}

# Create Route Table
resource "aws_route_table" "first_RT" {
  vpc_id = aws_vpc.First_vpc.id
  tags = {
    Name = "first_RT"
  }
}

# Create Route
resource "aws_route" "first_route" {
  route_table_id         = aws_route_table.first_RT.id
  destination_cidr_block = "0.0.0.0/0"
  internet_gateway_id    = aws_internet_gateway.first_igw.id
}
