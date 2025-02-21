variable "project" {
  type = string
  description = "Project name"
}

variable "vpc_cidr" {
  type = string
  description = "CIDR of VPC"
}

variable "public_subnet1" {
  type = string
  description = "CIDR of Public subnet 1"
}

variable "public_subnet2" {
  type = string
  description = "CIDR of Public subnet 2"
}

variable "private_subnet1" {
  type = string
  description = "CIDR of Private subnet 1"
}

variable "private_subnet2" {
  type = string
  description = "CIDR of Private subnet 2"
}