locals {
  project = "2-tier-app"
}

module "vpc" {
  source          = "./modules/network"
  vpc_cidr        = "10.0.0.0/16"
  public_subnet1  = "10.0.1.0/24"
  public_subnet2  = "10.0.2.0/24"
  private_subnet1 = "10.0.3.0/24"
  private_subnet2 = "10.0.4.0/24"
  project         = local.project
}

module "security" {
  source     = "./modules/security"
  vpc_id     = module.vpc.VPC_ID
  ssh_subnet1 = "10.0.1.0/24"
  ssh_subnet2 = "10.0.2.0/24"
  project    = local.project
}

module "database" {
  source         = "./modules/rds"
  db_pvt_subnet1 = module.vpc.PRIV_SUB_1_ID
  db_pvt_subnet2 = module.vpc.PRIV_SUB_2_ID
  db_name        = "wordpressdb"
  db_user        = "admin"
  db_password    = var.database_password  
  db_sg_id       = module.security.DB_SG_ID
  project        = local.project
}

module "infra" {
  source        = "./modules/ec2"
  instance_type = "t2.micro"
  ami           = "ami-053b0d53c279acc90"
  web_sg_id     = module.security.EC2_SG_ID
  pub_sub_1_id  = module.vpc.PUB_SUB_1_ID
  pub_sub_2_id  = module.vpc.PUB_SUB_2_ID
  db_user       = "admin"
  db_password   = var.database_password
  rds_endpoint  = module.database.RDS_ENDPOINT
  project       = local.project

  depends_on    = [ module.database ]
}

module "load_balancer"{
  source    = "./modules/alb"
  vpc_id    = module.vpc.VPC_ID
  web_sg    = module.security.ALB_SG_ID
  pub_sub1  = module.vpc.PUB_SUB_1_ID
  pub_sub2  = module.vpc.PUB_SUB_2_ID
  web_ec2_1 = module.infra.INSTANCE_1_ID
  web_ec2_2 = module.infra.INSTANCE_2_ID
  project   = local.project

  depends_on = [ module.infra ]
}