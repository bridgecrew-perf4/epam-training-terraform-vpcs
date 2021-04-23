data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "wordpress1" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  vpc_id = aws_vpc.wordpress_production.id

  tags = {
    Name = "wordpress_server1"
  }
}

resource "aws_instance" "wordpress2" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  vpc_id = aws_vpc.wordpress_production.id

  tags = {
    Name = "wordpress_server2"
  }
}