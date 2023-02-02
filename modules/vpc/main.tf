resource "aws_vpc" "main" {
    cidr_block = var.vpc_cidr
    instance_tenancy = "default"

    tags = {
        Name = "AT"
    }
}
resource "aws_subnet" "Public_subnet1" {
  vpc_id     = aws_vpc.main.id
  availability_zone = var.az[0]
  cidr_block = var.pub_cidr[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "Public subnet1"
  }
}
resource "aws_subnet" "Public_subnet2" {
  vpc_id     = aws_vpc.main.id
  availability_zone = var.az[1]
  cidr_block = var.pub_cidr[1]
  

  tags = {
    Name = "Public subnet2"
  }
}
resource "aws_subnet" "Private_subnet1" {
  vpc_id     = aws_vpc.main.id
  availability_zone = var.az[0]
  cidr_block = var.prv_cidr[0]

  tags = {
    Name = "Private subnet1"
  }
}
resource "aws_subnet" "Private_subnet2" {
  vpc_id     = aws_vpc.main.id
  availability_zone = var.az[1]
  cidr_block = var.prv_cidr[1]

  tags = {
    Name = "Private subnet2"
  }
}
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "AT-igw"
  }
}
resource "aws_eip" "nat_eip" {
  provider = aws
  vpc      = "true"

  tags = {
    Name  = "nat_eip"
    }
    }
    resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.Public_subnet2.id

  tags = {
    Name = "AT-nat"
  }
  }
  resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = var.pub_rt_cidr
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "Public RouteTable"
  }
}
resource "aws_route_table" "prv_rt" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = var.prv_rt_cidr
    gateway_id = aws_nat_gateway.nat.id
  }
  tags = {
    Name = "Private RouteTable"
  }
}
resource "aws_route_table_association" "a" {
  subnet_id = aws_subnet.Public_subnet1.id
  route_table_id = aws_route_table.public_rt.id
}
resource "aws_route_table_association" "b" {
  subnet_id = aws_subnet.Public_subnet2.id
  route_table_id = aws_route_table.public_rt.id
}
resource "aws_route_table_association" "c" {
  subnet_id = aws_subnet.Private_subnet1.id
  route_table_id = aws_route_table.prv_rt.id
}
resource "aws_route_table_association" "d" {
  subnet_id = aws_subnet.Private_subnet2.id
  route_table_id = aws_route_table.prv_rt.id
}
output  "vpcid" {
  value = aws_vpc.main.id
}
output "pub1_sub" {
    value = aws_subnet.Public_subnet1.id
}
output "pub2_sub" {
  value = aws_subnet.Public_subnet2.id
}
output "prv1_sub" {
    value = aws_subnet.Private_subnet1.id
}