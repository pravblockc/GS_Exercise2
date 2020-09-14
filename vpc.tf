# Configure the AWS Provider
provider "aws" {
  region  = var.region
  # Provide access and security keys
  access_key = < "Provide access key" >
  secret_key = < "Provide secret key" >
}

resource "aws_key_pair" "demo-keypair" {
  key_name   = "new-keypair"
  public_key = file(var.key_path)
}

resource "aws_vpc" "demo-vpc" {
  cidr_block = "10.0.0.0/16"

    tags = {
    Name = "Demo VPC"
  }
}

resource "aws_subnet" "public-subnet" {
  vpc_id     = aws_vpc.demo-vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = var.availability_zone

  tags = {
    Name = "PublicSubnet"
  }
}

resource "aws_subnet" "private-subnet" {
  vpc_id     = aws_vpc.demo-vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = var.availability_zone

  tags = {
    Name = "PrivateSubnet"
  }
}

resource "aws_instance" "demo-server" {
  ami           = "ami-0a63f96e85105c6d3"
  instance_type = "t2.micro"
  key_name = aws_key_pair.demo-keypair.key_name
  availability_zone = var.availability_zone

    network_interface {
        device_index         = 0
        network_interface_id = aws_network_interface.demo-public-nic.id
    }

    network_interface {
        device_index         = 1
        network_interface_id = aws_network_interface.demo-private-nic.id
    }
  
  tags = {
    Name = "Demo Server"
  }
}

resource "aws_network_interface" "demo-public-nic" {
  subnet_id       = aws_subnet.public-subnet.id
  private_ips     = ["10.0.1.10"]

}

  resource "aws_network_interface" "demo-private-nic" {
  subnet_id       = aws_subnet.private-subnet.id
  private_ips     = ["10.0.2.10"]

}
