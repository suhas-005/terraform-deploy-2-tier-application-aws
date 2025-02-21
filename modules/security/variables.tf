variable "project" {
  type = string
  description = "Project name"
}

variable "vpc_id" {
  type = string
  description = "VPC ID"
}

variable "ssh_subnet1" {
  type = string
  description = "Subnet of CIDR to allow SSh"
}

variable "ssh_subnet2" {
  type = string
  description = "Subnet of CIDR to allow SSh"
}