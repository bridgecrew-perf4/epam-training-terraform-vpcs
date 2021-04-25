provider "aws" {

  region = var.aws_region

}



resource "local_file" "sshconfig" {
 content = templatefile("config.tmpl",
 {
     wp1ip       = aws_instance.wordpress1.private_ip
     wp2ip       = aws_instance.wordpress1.private_ip
     bastionip   = aws_instance.bastion.public_ip
 }
 )
 filename = "config"

}

resource "local_file" "wordpress_config" {
 content = templatefile("wp-config.tmpl",
 {
     dbip       = aws_db_instance.epam_training_wpdb1.address
 }
 )
 filename = "wordpress/templates/wp-config.j2"

}

resource "null_resource" "cp_ssh_file" {
  provisioner "local-exec" {
    command = "cp config ~/.ssh/config"
  }
}

resource "null_resource" "run_ansible" {
  provisioner "local-exec" {
    command = "ansible-playbook -i inventory playbook.yml"
  }
}

