resource "aws_instance" "wordpress1" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name = "epam-new"

  network_interface {
    network_interface_id = aws_network_interface.wrordpress_1.id
    device_index         = 0
  }

  tags = {
    Name = "wordpress_server1"
  }
}

resource "aws_instance" "wordpress2" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name = "epam-new"

  network_interface {
    network_interface_id = aws_network_interface.wrordpress_2.id
    device_index         = 0
  }

  tags = {
    Name = "wordpress_server2"
  }
}

resource "aws_instance" "bastion" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name = "epam-new"

  network_interface {
    network_interface_id = aws_network_interface.bastion.id
    device_index         = 0
  }

  tags = {
    Name = "bastion server"
  }
}