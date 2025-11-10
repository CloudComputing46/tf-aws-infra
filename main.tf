provider "aws" {
  region = var.aws_region
}

resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.project}-vpc"
  }
}

resource "aws_subnet" "subnets" {
  for_each = var.subnets

  vpc_id = aws_vpc.main.id
  cidr_block = each.value.cidr_block
  availability_zone = each.value.availability_zone
  map_public_ip_on_launch = each.value.public

  tags = {
    Name = each.key
    Type = each.value.public ? "public" : "private"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main-igw"
  }
}

resource "aws_route_table" "public_route_tables" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = var.internet_cidr_block
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "public_route_table_association" {
  route_table_id = aws_route_table.public_route_tables.id
  for_each = {
    for key, subnet in aws_subnet.subnets :
      key => subnet if subnet.tags["Type"] == "public"
  }
  subnet_id = each.value.id
}

resource "aws_route_table" "private_route_tables" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route_table_association" "private_route_table_association" {
  route_table_id = aws_route_table.private_route_tables.id
  for_each = {
    for key, subnet in aws_subnet.subnets :
    key => subnet if subnet.tags["Type"] == "private"
  }
  subnet_id = each.value.id
}