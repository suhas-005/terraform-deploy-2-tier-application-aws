resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.project}-vpc"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.project}-igw"
  }
}

resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.project}-route-table"
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "pub-sub-1" {
  availability_zone       = data.aws_availability_zones.available.names[0]
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnet1
  map_public_ip_on_launch = "true"

  tags = {
    Name = "${var.project}-pub-sub1"
  }
}

resource "aws_subnet" "pub-sub-2" {
  availability_zone       = data.aws_availability_zones.available.names[1]
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnet2
  map_public_ip_on_launch = "true"

  tags = {
    Name = "${var.project}-pub-sub2"
  }
}

resource "aws_route_table_association" "pub-sub1-rt-assoc" {
  subnet_id      = aws_subnet.pub-sub-1.id
  route_table_id = aws_route_table.route_table.id
}

resource "aws_route_table_association" "pub-sub2-rt-assoc" {
  subnet_id      = aws_subnet.pub-sub-2.id
  route_table_id = aws_route_table.route_table.id
}

resource "aws_subnet" "priv-sub-1" {
  availability_zone       = data.aws_availability_zones.available.names[0]
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.private_subnet1

  tags = {
    Name = "${var.project}-priv-sub1"
  }
}

resource "aws_subnet" "priv-sub-2" {
  availability_zone       = data.aws_availability_zones.available.names[1]
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.private_subnet2

  tags = {
    Name = "${var.project}-priv-sub2"
  }
}