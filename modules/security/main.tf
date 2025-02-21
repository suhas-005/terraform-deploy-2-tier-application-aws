# ALB SG
resource "aws_security_group" "alb_sg" {
  name        = "web_traffic_sg"
  description = "Allow internet traffic to access webpage"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.project}-alb-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.alb_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_https" {
  security_group_id = aws_security_group.alb_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_egress_rule" "allow_all_egress" {
  security_group_id = aws_security_group.alb_sg.id
  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = -1
}

# EC2 SG
resource "aws_security_group" "ec2_sg" {
  name        = "ec2_sg"
  description = "Allow traffic to EC2"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.project}-ec2-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_alb" {
  security_group_id = aws_security_group.ec2_sg.id
  referenced_security_group_id = aws_security_group.alb_sg.id
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh1" {
  security_group_id = aws_security_group.ec2_sg.id
  cidr_ipv4         = var.ssh_subnet1
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh2" {
  security_group_id = aws_security_group.ec2_sg.id
  cidr_ipv4         = var.ssh_subnet2
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "allow_ec2_egress" {
  security_group_id = aws_security_group.ec2_sg.id
  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = -1
}

# Database SG
resource "aws_security_group" "db_sg" {
  name        = "db_traffic_sg"
  description = "Allow traffic to DB"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.project}-db-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_db_connections" {
  security_group_id            = aws_security_group.db_sg.id
  referenced_security_group_id = aws_security_group.ec2_sg.id
  from_port                    = 3306
  ip_protocol                  = "tcp"
  to_port                      = 3306
}

resource "aws_vpc_security_group_egress_rule" "allow_db_egress" {
  security_group_id = aws_security_group.db_sg.id
  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = -1
}
