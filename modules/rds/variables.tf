variable "project" {
  type = string
  description = "Project name"
}

variable "db_pvt_subnet1" {
  type = string
  description = "ID of DB Private subnet 1"
}

variable "db_pvt_subnet2" {
  type = string
  description = "ID of DB Privaet subnet 2"
}

variable "db_name" {
  type = string
  description = "DB Name"
}

variable "db_user" {
  type = string
  description = "DB User"
}

variable "db_password" {
  type = string
  description = "DB Password"
}

variable "db_sg_id" {
  type = string
  description = "DB Security Group"
}