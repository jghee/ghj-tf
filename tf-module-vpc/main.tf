terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "ap-northeast-2"
}

# VPC
resource "aws_vpc" "test-ghj-vpc" {
  cidr_block = "10.0.0.0/16"
}

# Subnet
resource "aws_subnet" "public" {
  count = var.public_subnet.count
  cidr_block = var.public_subnet.cidr[count.index]
  vpc_id     = aws_vpc.test-ghj-vpc.id

  availability_zone = "${var.region}${var.azs[count.index]}"
}

resource "aws_subnet" "private" {
  count = var.private_subnet.count
  cidr_block = var.private_subnet.cidr[count.index]
  vpc_id     = aws_vpc.test-ghj-vpc.id

  availability_zone = "${var.region}${var.azs[count.index]}"
}

resource "aws_subnet" "database" {
  count = var.database_subnet.count
  cidr_block = var.database_subnet.cidr[count.index]
  vpc_id     = aws_vpc.test-ghj-vpc.id

  availability_zone = "${var.region}${var.azs[count.index]}"
}

# NAT Gateway
resource "aws_eip" "test-ghj-nat-eip" {
  vpc = true
}

resource "aws_nat_gateway" "test-ghj-nat" {
  subnet_id = aws_subnet.public[0].id
  allocation_id = aws_eip.test-ghj-nat-eip.id

  tags = {
    Name = "test-ghj"
  }
}