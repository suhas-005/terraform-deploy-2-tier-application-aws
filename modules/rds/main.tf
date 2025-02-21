resource "aws_db_subnet_group" "database_subnet" {
  name       = "db subnet"
  subnet_ids = [var.db_pvt_subnet1, var.db_pvt_subnet2]
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_db_instance" "rds_primary" {
  identifier              = "readwrite-rds-instance"
  allocated_storage       = 5
  engine                  = "mysql"
  engine_version          = "8.4.4"
  instance_class          = "db.t3.micro"
  db_name                 = var.db_name
  username                = var.db_user
  password                = var.db_password
  backup_retention_period = 7
  multi_az                = false
  availability_zone       = data.aws_availability_zones.available.names[0]
  db_subnet_group_name    = aws_db_subnet_group.database_subnet.id
  skip_final_snapshot     = true
  vpc_security_group_ids  = [var.db_sg_id]
  storage_encrypted       = true

  tags = {
    Name = "${var.project}-rds-primary"
  }
}

resource "aws_db_instance" "rds_replica" {
  replicate_source_db    = aws_db_instance.rds_primary.identifier
  instance_class         = "db.t3.micro"
  identifier             = "replica-rds-instance"
  allocated_storage      = 5
  skip_final_snapshot    = true
  multi_az               = false
  availability_zone      =  data.aws_availability_zones.available.names[1]
  vpc_security_group_ids = [var.db_sg_id]
  storage_encrypted      = true

  tags = {
    Name = "${var.project}-rds-replica"
  }
}