resource "aws_vpc" "wordpress_production" {
  cidr_block = "10.168.0.0/16"
}

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.wordpress_production.id
  cidr_block = "10.168.168.0/24"

  tags = {
    Name = "load_balancer"
  }
}

resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.wordpress_production.id
  cidr_block = "10.168.30.0/24"

  tags = {
    Name = "web_servers"
  }
}

resource "aws_subnet" "db" {
  vpc_id     = aws_vpc.wordpress_production.id
  cidr_block = "10.168.50.0/24"

  tags = {
    Name = "rds"
  }
}

resource "aws_internet_gateway" "wordpress_igw" {
  vpc_id = aws_vpc.wordpress_production.id

  tags = {
    Name = "load_balancer"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.wordpress_production.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.wordpress_igw.id
  }
  tags = {
    Name = "public route table"
  }
}

resource "aws_eip" "static" {
  vpc      = true
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.static.id
  subnet_id     = aws_subnet.public.id

  tags = {
    Name = "nat gateway"
  }
}

resource "aws_route_table" "ptivate_route_table" {
  vpc_id = aws_vpc.wordpress_production.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gateway.id
  }
  tags = {
    Name = "private route table"
  }
}
