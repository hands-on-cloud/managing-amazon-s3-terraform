#fetching VPC state data from s3 bucket:
data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "terraform-remote-backend-20220527093846103400000001"
    key    = "terraform.tfstate"
    region = "ap-south-1"
  }
}

#creating required variables using values from VPC state data:

variable "sg_ids" {
  type        = list(string)
  description = "List of Security Group IDs to associate with the instances"
  default     = data.terraform_remote_state.vpc.outputs.security_group_ids
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of Subnet IDs to associate with the instances"
  default     = data.terraform_remote_state.vpc.outputs.subnet_ids
}

variable "region" {
  type        = string
  description = "The AWS Region to use"
  default     = "ap-south-1"
}


