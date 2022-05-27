terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.15.1"
    }
  }

  #specifying remote backend configuration:
  backend "s3" {
    bucket         = "terraform-remote-backend-20220527093846103400000001"
    key            = "terraform-vpc.tfstate" #the file name with which state will get saved
    region         = "ap-south-1"        #cant use variable here
    dynamodb_table = "terraform-state-lock"
  }
}

provider "aws" {
  region = var.region
}

