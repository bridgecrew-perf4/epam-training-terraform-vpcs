resource "aws_security_group" "elb_sg" {
  name        = "allow http and https to elb"
  description = "Allow http and https inbound traffic"
  vpc_id      = aws_vpc.wordpress_production.id

  dynamic "ingress" {
    for_each = ["80", "443"]
    content {
      description = "allow http and https from public"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow http and https worldwire"
  }
}

resource "aws_security_group" "bastion-sg" {
  name        = "allow ssh to bastion"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.wordpress_production.id

  ingress {
    description = "SSH from world"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_ssh"
  }
}

resource "aws_security_group" "wordpress-sg" {
  name        = "allow http and ssl to bastion"
  description = "Allow http and https inbound traffic"
  vpc_id      = aws_vpc.wordpress_production.id

  dynamic "ingress" {
    for_each = ["80", "443", "22"]
    content {
      description = "allow http and https from public"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["10.168.168.0/24"]
    }
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow http and https"
  }
}

resource "aws_security_group" "database-sg" {
  name        = "allow to db"
  description = "allow to database"
  vpc_id      = aws_vpc.wordpress_production.id

  ingress {
    description = "databace from private"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["10.168.30.0/24"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_ssh"
  }
}
