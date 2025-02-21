variable "project" {
  type = string
  description = "Project name"
}

variable "instance_type" {
  default = "t2.micro"
  description = "Instance Type"
}

variable "ami" {
    default = "ami-053b0d53c279acc90"
    description = "AMI ID"
}

variable "web_sg_id" {
  type = string
  description = "ID of Web Security Group"
}

variable "pub_sub_1_id" {
  type = string
  description = "ID of Public Subnet 1"
}

variable "pub_sub_2_id" {
  type = string
  description = "ID of Public Subnet 2"
}

variable "db_user" {
  type = string
  description = "DB User"
}

variable "db_password" {
  type = string
  description = "DB Password"
}

variable "rds_endpoint" {
  type = string
  description = "RDS endpoint"
}