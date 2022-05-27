variable "region" {
  type        = string
  description = "The AWS Region to use"
  default     = "ap-south-1"
}

variable "vpc_name" {
  type        = string
  description = "The name of the VPC to use"
  default     = "terraform-remote-backend-vpc"
}


variable "vpc_cidr" {
  type        = string
  description = "The CIDR block to use for the VPC"
  default     = "10.0.0.0/16"
}