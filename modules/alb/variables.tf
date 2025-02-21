variable "project" {
  type = string
  description = "Project name"
}

variable "vpc_id" {
  type = string
  description = "ID of VPC"
}

variable "web_sg" {
  type = string
  description = "ID of Security group for web traffic"
}

variable "pub_sub1" {
  type = string
  description = "ID of Public subnet 1"
}

variable "pub_sub2" {
  type = string
  description = "ID of Public subnet 2"
}

variable "web_ec2_1" {
  type = string
  description = "ID of EC2 instance 1"
}

variable "web_ec2_2" {
  type = string
  description = "ID of EC2 instance 2"
}