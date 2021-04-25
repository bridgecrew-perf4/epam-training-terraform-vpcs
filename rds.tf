resource "aws_db_instance" "epam_training_wpdb1" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t2.micro"
  name                 = "wp_db"
  username             = "wp_user"
  password             = "epam_pass"
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
  vpc_security_group_ids = [ aws_security_group.database-sg.id ]
  db_subnet_group_name = aws_db_subnet_group.rds.name

}