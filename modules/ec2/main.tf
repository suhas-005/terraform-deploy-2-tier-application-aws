resource "aws_key_pair" "client_key" {
    key_name = "client_key"
    public_key = file("./modules/ec2/client_key.pub")
}

resource "aws_instance" "server_1" {
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = var.pub_sub_1_id
  vpc_security_group_ids = [var.web_sg_id]
  key_name               = "client_key"
  user_data              = file("./modules/ec2/install_script.sh")
  tags = {
    Name = "${var.project}-instance-1"
  }
  # depends_on = [
  #   aws_db_instance.rds_master,
  # ]
}

resource "aws_instance" "server_2" {
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = var.pub_sub_2_id
  vpc_security_group_ids = [var.web_sg_id]
  key_name               = "client_key"
  user_data              = file("./modules/ec2/install_script.sh")
  tags = {
    Name = "${var.project}-instance-2"
  }
  # depends_on = [
  #   aws_db_instance.rds_master,
  # ]
}