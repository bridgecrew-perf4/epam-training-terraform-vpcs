resource "aws_network_interface" "bastion" {
  subnet_id = aws_subnet.public.id
  security_groups = [ aws_security_group.bastion-sg.id ]

  tags = {
    Name = "bastion server interface"
  }
}

resource "aws_network_interface" "wrordpress_2" {
  subnet_id = aws_subnet.private.id
  security_groups = [ aws_security_group.wordpress-sg.id ]

  tags = {
    Name = "wordpress2 network interface"
  }
}

resource "aws_network_interface" "wrordpress_1" {
  subnet_id = aws_subnet.private.id
  security_groups = [ aws_security_group.wordpress-sg.id ]

  tags = {
    Name = "wordpress1 network interface"
  }
}